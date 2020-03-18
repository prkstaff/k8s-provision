#!/bin/bash


provision_prod () {
  echo "provisioning production"
}

provision_dev () {
	terraform init
	terraform apply scripts/terraform/gke_cluster
}

case $1 in
  "prod" ) provision_prod
    ;;
  "dev" ) provision_dev
    ;;
esac


