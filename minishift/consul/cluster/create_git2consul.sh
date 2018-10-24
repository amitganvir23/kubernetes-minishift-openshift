oc login -u admin -p admin
#=============================
namespace=glt-consul
oc project ${namespace}
oc create -n ${namespace} -f  glt-dev/git2consul.yml
oc get pods -n ${namespace}		#To check Pods
oc get deployment -n ${namespace}
#oc describe pods git2consul
#=============================

