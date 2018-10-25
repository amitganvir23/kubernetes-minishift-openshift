oc login -u admin -p admin
namespace=glt-consul
oc delete -f consul-StatefulSet.yml -n ${namespace}
oc delete -f glt-dev/git2consul.yml -n ${namespace}
oc delete -f glt-qa/git2consul.yml -n ${namespace}