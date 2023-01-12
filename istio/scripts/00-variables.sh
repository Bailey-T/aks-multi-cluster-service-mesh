# Variables

# Edit the following
prefix="hfushi"
aksClusterOneLocation="uksouth"
aksClusterTwoLocation="uksouth"
sharedResourceGroupLocation="uksouth"

# Edit if you want to modify this project to add new features:
aksClusterOneName="$prefix-$aksClusterOneLocation-aks-one"
aksClusterTwoName="$prefix-$aksClusterTwoLocation-aks-two"
aksClusterOneResourceGroupName="$prefix-$aksClusterOneLocation-one-rg"
aksClusterTwoResourceGroupName="$prefix-$aksClusterTwoLocation-two-rg"
sharedResourceGroupName="$prefix-$sharedResourceGroupLocation-shared-rg"
terraformDirectory=".."
certsDir="../certificates"
tag="1.16.1"
istioDir="../istio-$tag"
yamlDir="../yaml"
clusters=($aksClusterOneName $aksClusterTwoName)
istioRevision="1-16-1"
yamlDir="../yaml"
namespace="curlserver"
podName="curlclient"
containerName="curlclient"
imageName="nginx"
command="curl -vv echoserver.echoserver.svc.cluster.local"
certificateName="frontend-certificate"
applicationGatewayName="aks-appgw-$aksClusterOneLocation"
rootCertificateName="root-certificate"
rootCertificateFile="../certificates/$aksClusterOneName/root-cert.pem"
echoserverCertificateName="echoserver"
echoserverDir="echoserver"

# Add the `istioctl` client to your path, on a macOS or Linux system
export PATH=$HOME/.istioctl/bin:$PATH