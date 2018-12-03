## Variables
namespace=glt-consul2

#===========

echo "=============== [List the Quota]"
kubectl -n ${namespace} get quota

echo "=============== [Describe what Quota set]"
kubectl -n ${namespace} describe quota quota-limit


###Create Quota limit to persistentvolumeclaims, pods, replicationcontrollers, resourcequotas, secrets and services
echo "=============== [Creating Quota]"
kubectl -n ${namespace} delete -f kube-quota.yml

kubectl -n ${namespace} get quota
kubectl -n ${namespace} describe quota quota-limit

## To test this limit try to create secrets.
#echo "hi" > a.txt;for i in 1 2 3 4 5 6 7;do kubectl -n ${namespace} create secret generic a_$i --from-file=./a.txt;done
