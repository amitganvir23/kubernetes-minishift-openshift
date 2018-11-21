## Variables
namespace=glt-consul2
sa_name=consul-serviceaccount2
acl_token=consul-token2
config_acl=consul2
config_dev=git2consul-dev2

#=========== 

## Creating Secret to store ACL Token for Git2consul to access Consul UI.
echo "============================ [Creating Secret of ACL TOKEN]"
kubectl create -n ${namespace} -f  consul-secret.yml


## Creating Configmap for git2consul to access json file in container
## To create config map for glt-consul env in git2consul-dev
kubectl.exe create configmap ${config_dev} --from-literal=message='git2consul-dev2' --from-file=glt-dev/config.json -n ${namespace}
kubectl.exe get configmap -n ${namespace}

## Launching Git2consul Container through Deployment
## Please create docker Image for git2consul before executing this script
kubectl create -n ${namespace} -f  glt-dev/git2consul.yml
