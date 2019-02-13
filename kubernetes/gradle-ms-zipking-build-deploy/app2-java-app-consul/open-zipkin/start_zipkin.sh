namespace=glt-dev
file=zipkin-ui-deployment.yml
## To create NameSpace
kubectl create -f ./create_namespace.yml

## Will Create one LoadBalancer Service and Deployment with tow pods
## 31001 port exposed
kubectl.exe -n ${namespace} create -f $file
kubectl.exe -n ${namespace} get pods

## Testing URL
#curl http://192.168.99.101:31001/