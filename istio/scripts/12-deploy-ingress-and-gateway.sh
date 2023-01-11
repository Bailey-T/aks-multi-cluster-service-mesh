#!/bin/bash

# Variables
source ./00-variables.sh


# Deploy the ingress to the echoserver namespace in the first cluster
kubectl apply --context=$aksClusterOneName -f $yamlDir/ingress.yaml

# Deploy the Istio gateway to the istio-ingress namespace in the first cluster
cat $yamlDir/gateway.yaml | sed -e "s/x.x.x.x/$(kubectl get ingress --context=$aksClusterOneName -n istio-ingress istio-ingress-application-gateway -o json | jq -r '.status.loadBalancer.ingress[0].ip')/" | kubectl apply --context=$aksClusterOneName -f -