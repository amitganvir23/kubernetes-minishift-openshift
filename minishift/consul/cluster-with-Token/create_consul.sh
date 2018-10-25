oc login -u admin -p admin
#=============================
oc create secret generic consul --from-file=consul-config/server.json -n glt-consul

#abc69de1-9eaf-465b-bb6c-1d317c4daf9a
#oc whoami
#system:admin
#echo -n 'abc69de1-9eaf-465b-bb6c-1d317c4daf9a' | base64
#YWJjNjlkZTEtOWVhZi00NjViLWJiNmMtMWQzMTdjNGRhZjlh


oc adm policy add-cluster-role-to-user cluster-admin admin
#oc login -u system:admin
#oc policy add-role-to-user view system:serviceaccount:glt-consul:consul-serviceaccount
oc policy add-role-to-user view system:serviceaccount:top-secret:robot
oc policy add-role-to-group view system:serviceaccounts -n glt-consul
oc policy add-role-to-group edit system:serviceaccounts:admin -n glt-consul

#=============================
oc login -u admin -p admin
namespace=glt-consul
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
#=============================
## To create config map for glt-dev env in git2consul-dev
oc create configmap git2consul-dev --from-literal=message='git2consul-dev' --from-file=glt-dev/config.json -n ${namespace}
#configmap "git2consul-dev" created

oc create configmap git2consul-qa --from-literal=message='git2consul-qa' --from-file=glt-qa/config.json -n ${namespace}
#configmap "git2consul-qa" created

oc create configmap git2consul-test --from-literal=message='git2consul-test' --from-file=glt-test/conf -n ${namespace}
#configmap "git2consul-test" created

oc get configmap -n ${namespace}

#oc delete configmap  --all # TO delete all config map

