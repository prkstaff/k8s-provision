output "cluster_name" {
  value = "developer-provision-terraform-${random_string.random_cluster_id.result}"
}
