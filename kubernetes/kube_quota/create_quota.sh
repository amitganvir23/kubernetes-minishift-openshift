## Variables
namespace=glt-consul2

#===========

###Create Quota limit to persistentvolumeclaims, pods, replicationcontrollers, resourcequotas, secrets and services
echo "=============== [Creating Quota]"
kubectl -n ${namespace} create -f kube-quota.yml

echo "=============== [List the Quota]"
kubectl -n ${namespace} get quota

echo "=============== [Describe what Quota set]"
kubectl -n ${namespace} describe quota quota-limit

## To test this limit try to create secrets.
#echo "hi" > a.txt;for i in 1 2 3 4 5 6 7;do kubectl -n ${namespace} create secret generic a_$i --from-file=./a.txt;done
