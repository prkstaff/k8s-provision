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
  name     = "developer-provision-terraform-${var.random_cluster_id}x"
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

data "google_client_config" "primary" {}

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

