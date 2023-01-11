# Variables
source ./00-variables.sh
(
istioctl uninstall --purge -y \
  --context=$aksClusterOneName

istioctl uninstall --purge -y \
  --context=$aksClusterTwoName

kubectl delete ns --context=$aksClusterOneName istio-ingress
kubectl delete ns --context=$aksClusterOneName istio-system
kubectl delete ns --context=$aksClusterOneName echoserver


kubectl delete ns --context=$aksClusterTwoName istio-ingress
kubectl delete ns --context=$aksClusterTwoName istio-system
kubectl delete ns --context=$aksClusterTwoName curlserver


)