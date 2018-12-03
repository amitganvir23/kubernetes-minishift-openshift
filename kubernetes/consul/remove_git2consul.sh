##### Variables
namespace=glt-consul2
sa_name=consul-serviceaccount2
acl_token=consul-token2
config_acl=consul2
config_dev=git2consul-dev2

#=========== 

##### Deleting configmap file
kubectl.exe -n ${namespace} delete configmap $config_dev $config_qa

##### Deleting service/deployment/pods
kubectl delete -n ${namespace} -f  glt-dev/git2consul.yml

## Deleting Secret to store ACL Token for Git2consul to access Consul UI.
kubectl delete -n ${namespace} -f  consul-secret.yml