#!/bin/bash - 

echo "Get Ingress Gateway IP script running." > get_ingress_gateway_ip.log
ID=$1
CLUSTER_RUNNING=false

# Wait cluster be READY
while [ $CLUSTER_RUNNING = false ]; do
  echo "Inside loop Waiting Cluster be Ready Loop" >> get_ingress_gateway_ip.log
  STATUS=$(gcloud container clusters describe developer-provision-terraform-${ID}x  --project=$3 --zone $2 --format json | jq '.nodePools[0].status')
  if [[ "$STATUS" = *"RUNNING"* ]]; then
    echo "Cluster State Running" >> get_ingress_gateway_ip.log
    CLUSTER_RUNNING=true
  else
    echo "Cluster not running yet." >> get_ingress_gateway_ip.log
    sleep 1m
  fi
done
INGRESS_IP=""
GOT_INGRESS_IP=false

# Connect CLI to cluster
source ./scripts/connect_to_cluster.sh "$@"

# Wait IP be ready
while [ $GOT_INGRESS_IP = false ] 
do
  echo "Inside Kubectl get svc ip." >> get_ingress_gateway_ip.log
  INGRESS_IP=$(kubectl get svc istio-ingressgateway -n istio-system | grep LoadBalancer | awk '{print $4}')
  if [ $INGRESS_IP = "" ] || [ $INGRESS_IP = "<none>" ] || [ $INGRESS_IP = "<pending>" ] ; then
    echo "Waiting ip to be available" >> get_ingress_gateway_ip.log
    sleep 1m
  else
    echo "Got Ingress Gateway IP" >> get_ingress_gateway_ip.log
    GOT_INGRESS_IP=true
    echo $INGRESS_IP >> get_ingress_gateway_ip.log
  fi
done
echo "Printing Ingress LB IP" >> get_ingress_gateway_ip.log
echo $INGRESS_IP
