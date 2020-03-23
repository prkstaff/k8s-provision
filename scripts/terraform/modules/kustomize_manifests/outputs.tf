output "dns_zone" {
  value = "renatoprado"
}
output "dns_name" {
  value = "renatoprado.com"
}
output "istio_ingress_gateway_ip" {
  value = data.external.istio_ingress_gateway_ip.result.data
}
