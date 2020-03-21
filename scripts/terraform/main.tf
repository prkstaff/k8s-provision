resource "random_string" "random_cluster_id" {
  length    = 6
  special   = false
  lower     = true
  min_lower = 6
}

module "gke_cluster" {
  source            = "./modules/gke_cluster"
  random_cluster_id = random_string.random_cluster_id.result
  zone              = var.zone
  region            = var.region
  project           = var.project
}

module "kustomize_manifests" {
  source = "./modules/kustomize_manifests"
}
