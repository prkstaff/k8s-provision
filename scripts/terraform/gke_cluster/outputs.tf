output "cluster_name" {
  value = "developer-provision-terraform-${random_string.random_cluster_id.result}"
}

#output "kubectl_filename_list" {
#  value = data.kubectl_filename_list.manifests.matches
#}

output "kustomize_data" {
  value = data.external.kustomize_data.result.data
}

output "Connect_to_gke_cluster" {
  value = "gcloud container clusters get-credentials developer-provision-terraform-${random_string.random_cluster_id.result}x --region ${var.region} --project ${var.project}"
}
