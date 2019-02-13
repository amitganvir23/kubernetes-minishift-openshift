namespace=glt-dev
file=zipkin-ui-deployment.yml

#============= delete
## Will delete one LoadBalancer Service and Deployment with tow pods
kubectl.exe -n ${namespace} delete -f $file


