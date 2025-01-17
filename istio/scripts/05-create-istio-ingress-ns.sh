#!/bin/bash

# Variables
source ./00-variables.sh

# Create the istio-ingress namespace in the first cluster
kubectl create --context=$aksClusterOneName namespace istio-ingress

# Enable automatic Istio sidecar injection for the istio-ingress namespace in the first cluster
kubectl label --context=$aksClusterOneName namespace istio-ingress istio.io/rev=$istioRevision --overwrite

# Namespace Network Label
kubectl label --context=$aksClusterOneName namespace istio-ingress topology.istio.io/network=network1 --overwrite

# Create the istio-ingress namespace in the second cluster
kubectl create --context=$aksClusterTwoName namespace istio-ingress

# Enable automatic Istio sidecar injection for the istio-ingress namespace in the second cluster
kubectl label --context=$aksClusterTwoName namespace istio-ingress istio.io/rev=$istioRevision --overwrite

# Namespace Network Label
kubectl label --context=$aksClusterTwoName namespace istio-ingress topology.istio.io/network=network2 --overwrite