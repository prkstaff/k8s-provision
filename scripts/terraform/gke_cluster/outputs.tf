output "cluster_name" {
  value = "developer-provision-terraform-${random_string.random_cluster_id.result}"
}

output  "kubectl_filename_list" {
  value = data.kubectl_filename_list.manifests.matches
}

output "GKE_cluster_username" {
  value = google_container_cluster.primary.master_auth.0.username
}

output "GKE_cluster_password" {
  value = google_container_cluster.primary.master_auth.0.password
}
