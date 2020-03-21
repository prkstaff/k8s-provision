#!/bin/bash


provision_prod () {
  echo "provisioning production"
}

provision_dev () {
  cd scripts/terraform/
  terraform init
	terraform apply
}

case $1 in
  "prod" ) provision_prod
    ;;
  "dev" ) provision_dev
    ;;
esac


