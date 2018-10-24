oc login -u admin -p admin
namespace=glt-consul
oc delete -f consul-StatefulSet.yml -n ${namespace}