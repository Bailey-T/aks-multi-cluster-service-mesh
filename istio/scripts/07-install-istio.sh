#!/bin/bash

# Variables
source ./00-variables.sh

# Change the working directory to the yaml folder
(
cd $yamlDir

# Install Istio on cluster one
istioctl install -y \
  --context=$aksClusterOneName \
  --set profile=minimal \
  --revision=$istioRevision \
  --set tag=$tag \
  -f 001-accessLogFile.yaml \
  -f 002-multicluster-region-one.yaml \
  -f 003-istiod-csi-secrets.yaml \
  -f 004-ingress-gateway-1.yaml \
  -f 005-aks-affinity.yaml \
  -f 006-dns-proxy.yaml


# Install Istio on cluster two
istioctl install -y \
  --context=$aksClusterTwoName \
  --set profile=minimal \
  --revision=$istioRevision \
  --set tag=$tag \
  -f 001-accessLogFile.yaml \
  -f 002-multicluster-region-two.yaml \
  -f 003-istiod-csi-secrets.yaml \
  -f 004-ingress-gateway-2.yaml \
  -f 005-aks-affinity.yaml \
  -f 006-dns-proxy.yaml


# Apply Strict Inbound MTLS
# Sleep is to wait for CRDs to settle
sleep 5
kubectl apply --context $aksClusterOneName -f peerAuthentication.yaml
kubectl apply --context $aksClusterTwoName -f peerAuthentication.yaml

)