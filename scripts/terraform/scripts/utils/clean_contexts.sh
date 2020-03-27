#!/bin/bash - 

CURRENT_CONTEXT=$(kubectl config current-context)
CONTEXTS=$(kubectl config get-contexts | grep developer-provision-terraform | awk '{print $2}')

for context in $CONTEXTS; do
  if [ $CURRENT_CONTEXT = $context ]; then
    echo "Skipping, got the current context"
  else
    kubectl config delete-context $context
  fi
done


