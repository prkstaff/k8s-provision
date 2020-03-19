#!/bin/bash


provision_prod () {
  echo "provisioning production"
}

provision_dev () {
  cd scripts/terraform/gke_cluster
  terraform init
	terraform apply
}

case $1 in
  "prod" ) provision_prod
    ;;
  "dev" ) provision_dev
    ;;
esac


