#!/bin/bash

# Variables
source ./00-variables.sh

echo "calling locally"
curl -v $(kubectl get ingress -n istio-ingress --context=$aksClusterOneName istio-ingress-application-gateway -o json | jq -r '.status.loadBalancer.ingress[0].ip').nip.io

echo "calling from cluster 2"
# Create pod if not exists
result=$(kubectl get pod --context=$aksClusterTwoName --namespace $namespace -o jsonpath="{.items[?(@.metadata.name=='$podName')].metadata.name}")

if [[ -n $result ]]; then
    echo "[$podName] pod already exists in the [$namespace] namespace"
else
    echo "[$podName] pod does not exist in the [$namespace] namespace"
    echo "creating [$podName] pod in the [$namespace] namespace..."
    kubectl run $podName --image=$imageName --namespace $namespace --context=$aksClusterTwoName

    while [[ $(kubectl get pod --context=$aksClusterTwoName --namespace $namespace -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do
        echo "waiting for [$podName] pod"
        sleep 1
    done
fi

# Invoke the echoserver as a local service
kubectl exec -it $podName --context=$aksClusterTwoName --namespace $namespace --container $containerName -- $command

# Delete the pod
#kubectl delete pod $podName --context=$aksClusterTwoName --namespace $namespace
