output "cluster_name" {
  value = "developer-provision-terraform-${random_string.random_cluster_id.result}"
}

output "Connect_to_gke_cluster" {
  value = "gcloud container clusters get-credentials developer-provision-terraform-${random_string.random_cluster_id.result}x --region ${var.region} --project ${var.project}"
}

output "Endpoint_DNS" {
  value = "api.${random_string.random_cluster_id.result}x.${var.dns_name}."

}
