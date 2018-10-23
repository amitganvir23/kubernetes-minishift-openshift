oc login -u admin -p admin
namespace=glt-dev
oc new-project ${namespace} --description="${namespace}" --display-name="${namespace}"
oc get projects
oc project ${namespace}
oc create -n ${namespace} -f  consul-StatefulSet.yml
#oc create -n ${namespace} -f  git2consul.yml
oc get pods -n ${namespace}		#To check Pods
oc get svc  -n ${namespace}		#To check Services
oc get StatefulSet -n ${namespace}
oc get ep		#To check End point 
oc describe pods consul