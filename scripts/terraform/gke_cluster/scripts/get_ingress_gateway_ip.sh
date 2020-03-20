#!/bin/bash - 

source ./connect_to_cluster.sh "$@"

kubectl get svc istio-ingressgateway -n istio-system | grep LoadBalancer | awk '{print $4}'

