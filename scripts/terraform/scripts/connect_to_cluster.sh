#!/bin/bash -

RANDOM_STRING=$1
REGION=$2
PROJECT=$3

gcloud container clusters get-credentials developer-provision-terraform-${RANDOM_STRING}x --region ${REGION} --project ${PROJECT}

