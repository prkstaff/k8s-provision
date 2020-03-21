#!/bin/bash


destroy_prod () {
  echo "destroying production"
}

destroy_dev () {
  cd scripts/terraform/
  terraform init
	terraform destroy
}

case $1 in
  "prod" ) destroy_prod
    ;;
  "dev" ) destroy_dev
    ;;
esac


