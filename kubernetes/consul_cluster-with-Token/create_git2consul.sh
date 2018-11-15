## Variables
namespace=glt-consul
sa_name=consul-serviceaccount
acl_token=consul-token
config_acl=consul
config_dev=git2consul-dev
config_qa=git2consul-qa

#=========== 

## Creating Secret to store ACL Token for Git2consul to access Consul UI.
kubectl create -n ${namespace} -f  consul-secret.yml


## Creating Configmap for git2consul to access json file in container
## To create config map for glt-consul env in git2consul-dev
kubectl.exe create configmap git2consul-dev --from-literal=message='git2consul-dev' --from-file=glt-dev/config.json -n ${namespace}
kubectl.exe create configmap git2consul-qa --from-literal=message='git2consul-qa' --from-file=glt-qa/config.json -n ${namespace}
kubectl.exe get configmap -n ${namespace}

## Launching Git2consul Container through Deployment
## Please create docker Image for git2consul before executing this script
kubectl create -n ${namespace} -f  glt-dev/git2consul.yml
kubectl create -n ${namespace} -f  glt-qa/git2consul.yml