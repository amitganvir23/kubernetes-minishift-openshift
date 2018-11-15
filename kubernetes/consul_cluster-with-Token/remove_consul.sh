##### Variables
namespace=glt-consul
sa_name=consul-serviceaccount
acl_token=consul-token
config_acl=consul
config_dev=git2consul-dev
config_qa=git2consul-qa

#=========== 

##### Deleting all the resource of Consul and git2consul
kubectl delete -f consul-StatefulSet.yml -n ${namespace}
kubectl delete -f consul-service.yml -n ${namespace}

##### Deleting service account of consul
kubectl delete sa ${sa_name} -n ${namespace}

##### Deleting Consul Token and Configuration Token file
kubectl delete secrets -n ${namespace} ${acl_token}
kubectl delete secrets -n ${namespace} ${config_acl}

##### To delete namespace
kubectl.exe delete -f create_namespace.yml
##OR
#kubectl delete namespaces ${namespace}




