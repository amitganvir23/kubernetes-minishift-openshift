## Variables
namespace=glt-consul
sa_name=consul-serviceaccount
acl_token=consul-token
config_acl=consul
config_dev=git2consul-dev
config_qa=git2consul-qa

#=========== 

##### To create namespaces
kubectl.exe create -f create_namespace.yml
kubectl.exe get namespaces

##### It will create service account to access API's
kubectl create sa ${sa_name} -n ${namespace}
kubectl get sa -n ${namespace}
kubectl describe sa ${sa_name}

##### Creating Secret for Consul configuration of Token
kubectl create secret generic consul --from-file=consul-config/server.json -n ${namespace}
kubectl get secret -n ${namespace}


##### create StatefulSet/Pods and service
kubectl create -n ${namespace} -f  consul-StatefulSet.yml

kubectl get pods -n ${namespace}
kubectl get svc  -n ${namespace}		#To check Services
kubectl get StatefulSet -n ${namespace}
kubectl get ep -n ${namespace}	#To check End point 
#kubectl describe pods consul

##### Consul service to access consul UI.
kubectl create -n ${namespace} -f consul-service.yml


## Creating Secret to store ACL Token for Git2consul to access Consul UI.
kubectl create -n ${namespace} -f  consul-secret.yml