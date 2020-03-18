#!/bin/bash


destroy_prod () {
  echo "destroying production"
}

destroy_dev () {
	terraform destroy scripts/terraform/gke_cluster
}

case $1 in
  "prod" ) destroy_prod
    ;;
  "dev" ) destroy_dev
    ;;
esac


