#!/bin/bash

# Variables
source ./00-variables.sh

# Create istio-system namespace in AKS clusters
for cluster in ${clusters[@]} ; do
  kubectl create --context=$cluster namespace istio-system
done

# Namespace Network Label
kubectl label --context=$aksClusterOneName namespace istio-system topology.istio.io/network=network1 --overwrite
# Namespace Network Label
kubectl label --context=$aksClusterTwoName namespace istio-system topology.istio.io/network=network2 --overwrite

# Change the working directory to the Terraform folder
(
cd $terraformDirectory

# Create SecretProviderClass in the istio-system namespace in the first cluster
terraform output -raw secret_provider_class_location_one | kubectl --context=$aksClusterOneName -n istio-system apply -f -

# Create SecretProviderClass in the istio-system namespace in the second cluster
terraform output -raw secret_provider_class_location_two | kubectl --context=$aksClusterTwoName -n istio-system apply -f -
)
