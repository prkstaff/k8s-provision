resource "random_string" "random_cluster_id" {
  length    = 6
  special   = false
  lower     = true
  min_lower = 6
}

provider "google" {
  credentials = file("../account.json")
  project     = "jeitto-workshop"
  region      = "us-central1"
  zone        = "us-central1-a"
}

resource "google_container_cluster" "primary" {
  name     = "developer-provision-terraform-${random_string.random_cluster_id.result}x"
  location = "us-central1"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = true
    }
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = "us-central1"
  cluster    = google_container_cluster.primary.name
  node_count = 1

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

provider "kubectl" {
  load_config_file       = false
  host                   = google_container_cluster.primary.endpoint
  client_certificate = base64decode(google_container_cluster.primary.master_auth.0.client_certificate)
  client_key = base64decode(google_container_cluster.primary.master_auth.0.client_key)
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
}

data "kubectl_filename_list" "manifests" {
    pattern = "./manifests/*.yaml"
}

resource "kubectl_manifest" "test" {
    count = length(data.kubectl_filename_list.manifests.matches)
    yaml_body = file(element(data.kubectl_filename_list.manifests.matches, count.index))
}