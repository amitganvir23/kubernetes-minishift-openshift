##### Variables
namespace=glt-consul
sa_name=consul-serviceaccount
acl_token=consul-token
config_acl=consul
config_dev=git2consul-dev
config_qa=git2consul-qa

#=========== 

##### Deleting configmap file
kubectl.exe -n ${namespace} delete configmap $config_dev $config_qa

##### Deleting service/deployment/pods
kubectl delete -n ${namespace} -f  glt-dev/git2consul.yml


## Deleting Secret to store ACL Token for Git2consul to access Consul UI.
kubectl delete -n ${namespace} -f  consul-secret.yml