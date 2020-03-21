#!/bin/bash - 

>&2 echo "Get Ingress Gateway IP script running."
ID=$1
CLUSTER_RUNNING=false

# Wait cluster be READY
while [ $CLUSTER_RUNNING = false ]; do
  >&2 echo "Inside loop Waiting Cluster be Ready Loop"
  STATUS=$(gcloud container clusters describe developer-provision-terraform-${ID}x  --project=$3 --zone $2 --format json | jq '.nodePools[0].status')
  if [[ "$STATUS" = *"RUNNING"* ]]; then
    >&2 echo "Cluster State Running"
    CLUSTER_RUNNING=true
  else
    >&2 echo "Cluster not running yet."
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
  >&2 echo "Inside Kubectl get svc ip."
  INGRESS_IP=$(kubectl get svc istio-ingressgateway -n istio-system | grep LoadBalancer | awk '{print $4}')
  if [ $INGRESS_IP = "" ] || [ $INGRESS_IP = "<none>" ] || [ $INGRESS_IP = "<pending>" ] ; then
    >&2 echo "Waiting ip to be available"
    sleep 1m
  else
    >&2 echo "Got Ingress Gateway IP"
    GOT_INGRESS_IP=true
  fi
done
>&2 echo "Printing Ingress LB IP"
echo $INGRESS_IP
