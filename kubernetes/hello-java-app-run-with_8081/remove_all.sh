namespace=nginx-app

#============= delete
namespace=nginx-app
## Will delete one LoadBalancer Service and Deployment with tow pods
kubectl.exe -n ${namespace} delete -f nginx.yml

## To Delete NameSpace
kubectl delete namespaces ${namespace}

