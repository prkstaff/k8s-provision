output "cluster_name" {
  value = "developer-provision-terraform-${random_string.random_cluster_id.result}"
}

output "Connect_to_gke_cluster" {
  value = "gcloud container clusters get-credentials developer-provision-terraform-${random_string.random_cluster_id.result}x --region ${module.gke_cluster.region} --project ${module.gke_cluster.project}"
}

output "Endpoint_DNS" {
  value = "api.${random_string.random_cluster_id.result}x.${module.kustomize_manifests.dns_name}."

}
