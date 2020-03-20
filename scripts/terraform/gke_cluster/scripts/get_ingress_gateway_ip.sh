#!/bin/bash - 

source ./connect_to_cluster.sh "$@"

ID=$1
CLUSTER_RUNNING=false

# Wait cluster be READY
while [ $CLUSTER_RUNNING = false ]; do
  STATUS=$(gcloud container clusters describe developer-provision-terraform-${ID}x  --project=$3 --zone $2 --format json | jq '.nodePools[0].status')
  if [[ "$STATUS" = *"RUNNING"* ]]; then
    CLUSTER_RUNNING=true
  else
    sleep 1m
  fi
done
INGRESS_IP=""
GOT_INGRESS_IP=false
# Wait IP be ready
while [ $GOT_INGRESS_IP = false ] 
do
  INGRESS_IP=$(kubectl get svc istio-ingressgateway -n istio-system | grep LoadBalancer | awk '{print $4}')
  if [ $INGRESS_IP = "" ] || [ $INGRESS_IP = "<none>" ]; then
    sleep 1m
  else
    GOT_INGRESS_IP=true
  fi
done
echo $INGRESS_IP
