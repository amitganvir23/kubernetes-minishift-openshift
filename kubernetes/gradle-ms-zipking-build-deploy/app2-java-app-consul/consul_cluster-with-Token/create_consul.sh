## Variables
namespace=glt-consul
sa_name=consul-serviceaccount
acl_token=consul-token
config_acl=consul
config_dev=git2consul-dev
config_qa=git2consul-qa

#=========== 
##### To create namespaces
echo "============================ [Creating Namespace/project ${namespace}]"
kubectl.exe create -f create_namespace.yml
kubectl.exe get namespaces

##### It will create service account to access API's
echo "============================ [Creating service account: ${sa_name}]"
kubectl create sa ${sa_name} -n ${namespace}
kubectl get sa -n ${namespace}
kubectl describe sa ${sa_name} -n ${namespace}


##### Creating Secret for Consul configuration of Token
echo "============================ [Creating Consul Config secret: consul2]"
kubectl create secret generic consul --from-file=consul-config/server.json -n ${namespace}
kubectl get secret -n ${namespace}


##### create StatefulSet/Pods and service
echo "============================ [Creating and checking PODS/Service]"
kubectl create -n ${namespace} -f  consul-StatefulSet.yml

kubectl get pods -n ${namespace}
kubectl get svc  -n ${namespace}		#To check Services
kubectl get StatefulSet -n ${namespace}
kubectl get ep -n ${namespace}	#To check End point 
#kubectl describe pods consul
#kubectl get StatefulSet -n glt-consul consul -o yaml | egrep -A 6 "volumeMounts:"

##### Consul service to access consul UI.
echo "============================ [Creating Service to access Consul UI]"
kubectl create -n ${namespace} -f consul-service.yml


## Creating Secret to store ACL Token for Git2consul to access Consul UI.
echo "============================ [Creating Secret of ACL TOKEN]"
kubectl create -n ${namespace} -f  consul-secret.yml