resource "random_string" "random_cluster_id" {
  length    = 6
  special   = false
  lower     = true
  min_lower = 6
}

provider "google" {
  credentials = file("account.json")
  project     = var.project
  region      = var.region
  zone        = var.zone
  version     = "~> 3.0.0-beta.1"
}

provider "google-beta" {
  credentials = file("account.json")
  project     = var.project
  region      = var.region
  zone        = var.zone
}


resource "google_container_cluster" "primary" {
  provider = google-beta
  name     = "developer-provision-terraform-${random_string.random_cluster_id.result}x"
  location = var.region

  addons_config {
    istio_config {
      disabled = false
    }
  }

  node_locations = [var.zone]
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

}

resource "google_container_node_pool" "cluster_node_pool" {
  name       = "my-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = 4

  node_config {
    preemptible  = false
    machine_type = "n1-standard-1"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

data "external" "istio_ingress_gateway_ip" {

  program = ["bash", "-c", "INGRESS_IP=$(./scripts/get_ingress_gateway_ip.sh ${random_string.random_cluster_id.result} ${var.region} ${var.project}) && jq -n --arg kdata \"$INGRESS_IP\" '{\"data\":$kdata}'"]
}

resource "google_dns_record_set" "a" {
  name         = "api.${random_string.random_cluster_id.result}x.${var.dns_name}."
  managed_zone = var.dns_zone
  type         = "A"
  ttl          = 300

  rrdatas = [data.external.istio_ingress_gateway_ip.result.data]
}

data "google_client_config" "primary" {}

provider "kubectl" {
  load_config_file = false
  cluster_ca_certificate = base64decode(
    google_container_cluster.primary.master_auth[0].cluster_ca_certificate,
  )
  host  = google_container_cluster.primary.endpoint
  token = data.google_client_config.primary.access_token
}

data "external" "kustomize_data" {

  program = ["bash", "-c", "KUSTOMIZE_DATA=$(kubectl kustomize manifests/env/provision) && jq -n --arg kdata \"$KUSTOMIZE_DATA\" '{\"data\":$kdata}'"]
}

resource "kubectl_manifest" "test" {
  yaml_body = data.external.kustomize_data.result.data
}
