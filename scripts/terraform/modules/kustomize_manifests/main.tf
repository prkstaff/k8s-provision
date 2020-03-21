#data "external" "istio_ingress_gateway_ip" {
#
#  program = ["bash", "-c", "INGRESS_IP=$(./scripts/get_ingress_gateway_ip.sh ${random_string.random_cluster_id.result} ${var.region} ${var.project}) && jq -n --arg kdata \"$INGRESS_IP\" '{\"data\":$kdata}'"]
#}
#
#resource "google_dns_record_set" "a" {
#  name         = "api.${random_string.random_cluster_id.result}x.${var.dns_name}."
#  managed_zone = var.dns_zone
#  type         = "A"
#  ttl          = 300
#
#  rrdatas = [data.external.istio_ingress_gateway_ip.result.data]
#}
#
#data "google_client_config" "primary" {}
#
#provider "kubectl" {
#  load_config_file = false
#  cluster_ca_certificate = base64decode(
#    google_container_cluster.primary.master_auth[0].cluster_ca_certificate,
#  )
#  host  = google_container_cluster.primary.endpoint
#  token = data.google_client_config.primary.access_token
#}
#
#data "external" "kustomize_data" {
#
#  program = ["bash", "-c", "KUSTOMIZE_DATA=$(kubectl kustomize manifests/env/provision) && jq -n --arg kdata \"$KUSTOMIZE_DATA\" '{\"data\":$kdata}'"]
#}
#
#resource "kubectl_manifest" "test" {
#  yaml_body = data.external.kustomize_data.result.data
#}
