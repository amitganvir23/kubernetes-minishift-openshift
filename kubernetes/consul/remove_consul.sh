##### Variables
namespace=glt-consul2
sa_name=consul-serviceaccount2
acl_token=consul-token2
config_acl=consul2
config_dev=git2consul-dev2


#=========== 

##### Deleting all the resource of Consul and git2consul
kubectl delete -f consul-StatefulSet.yml -n ${namespace}

##### Deleting service account of consul
kubectl delete sa ${sa_name} -n ${namespace}

##### Deleting Consul Token and Configuration Token file
kubectl delete secrets -n ${namespace} ${acl_token}
kubectl delete secrets -n ${namespace} ${config_acl}

##### To delete namespace
kubectl.exe delete -f create_namespace.yml
##OR
#kubectl delete namespaces ${namespace}




