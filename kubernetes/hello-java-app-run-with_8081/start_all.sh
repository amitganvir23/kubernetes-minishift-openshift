namespace=glt-dev
## To create NameSpace
kubectl create -f ./create_namespace.yml
kubectl get namespaces

## Will Create one LoadBalancer Service and Deployment with tow pods
## 31001 port exposed
kubectl.exe -n ${namespace} create -f hello-app-deploy.yml
kubectl.exe -n ${namespace} get pods

## Testing URL with nodeport
#curl http://192.168.99.101:31005/