namespace=glt-dev
#defaultport is 8080

#============= delete
namespace=nginx-app
## Will delete one LoadBalancer Service and Deployment with tow pods
kubectl.exe -n ${namespace} delete -f hello-app-deploy.yml

## To Delete NameSpace
kubectl delete namespaces ${namespace}

