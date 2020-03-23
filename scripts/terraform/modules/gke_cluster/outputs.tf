output "project" {
  value = "jeitto-workshop"
}
output "region" {
  value = "us-central1"
}
output "zone" {
  value = "us-central1-a"
}
output "cluster_token" {
  value = "${data.google_client_config.primary.access_token}"
}
output "cluster_endpoint" {
  value = google_container_cluster.primary.endpoint
}
output "cluster_certificate" {
  value = base64decode(
    google_container_cluster.primary.master_auth[0].cluster_ca_certificate,
  )
}

