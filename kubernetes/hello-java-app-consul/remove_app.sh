namespace=glt-dev
file=hello-app-deploy.yml
#defaultport is 8080

#============= delete
## Will delete one LoadBalancer Service and Deployment with tow pods
kubectl.exe -n ${namespace} delete -f $file

## To Delete NameSpace
kubectl delete namespaces ${namespace}

