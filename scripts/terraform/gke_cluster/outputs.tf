output "cluster_name" {
  value = "developer-provision-terraform-${random_string.random_cluster_id.result}"
}

output  "kubectl_filename_list" {
  value = data.kubectl_filename_list.manifests.matches
}