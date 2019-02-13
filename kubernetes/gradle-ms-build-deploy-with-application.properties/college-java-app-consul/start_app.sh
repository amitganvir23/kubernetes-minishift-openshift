namespace=glt-dev
#defaultport is 8080
file=college-app-deploy.yml

## To create NameSpace
kubectl create -f ./create_namespace.yml
kubectl get namespaces

## Will Create one LoadBalancer Service and Deployment with tow pods
## 31001 port exposed
kubectl.exe -n ${namespace} create -f $file
kubectl.exe -n ${namespace} get pods

## Testing URL with nodeport
#curl http://192.168.99.101:31005/