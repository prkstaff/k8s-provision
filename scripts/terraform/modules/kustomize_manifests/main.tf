data "external" "istio_ingress_gateway_ip" {

  program = ["bash", "-c", "INGRESS_IP=$(./scripts/get_ingress_gateway_ip.sh ${var.random_cluster_id} ${var.region} ${var.project}) && jq -n --arg kdata \"$INGRESS_IP\" '{\"data\":$kdata}'"]
}

resource "google_dns_record_set" "a" {
  name         = "api.${var.random_cluster_id}x.${var.dns_name}."
  managed_zone = var.dns_zone
  type         = "A"
  ttl          = 300
  project      = var.project

  rrdatas = [data.external.istio_ingress_gateway_ip.result.data]
}


provider "kubectl" {
  load_config_file       = false
  cluster_ca_certificate = var.cluster_certificate
  host                   = var.cluster_endpoint
  token                  = var.cluster_token
}

data "external" "kustomize_data" {

  program = ["python3", "./scripts/external_kustomize_manifest.py"]
}

resource "kubectl_manifest" "test" {
  yaml_body = data.external.kustomize_data.result.data
}
