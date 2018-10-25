oc login -u admin -p admin
#=============================
namespace=glt-consul
oc project ${namespace}
oc delete -n ${namespace} -f  glt-dev/git2consul.yml
oc delete -n ${namespace} -f  glt-qa/git2consul.yml
#=============================

