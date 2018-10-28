## Variables
oc_user=admin
namespace=glt-consul
sa_name=consul-serviceaccount
acl_token=consul-token
config_acl=consul
config_dev=git2consul-dev
config_qa=git2consul-qa
#-----
## Login with admin
oc login -u ${oc_user} -p ${oc_user}

## Create Project/namespace
oc new-project ${namespace} --description="${namespace}" --display-name="${namespace}"

#----- Manage Service account and poliy

## It will create service account to access API's
oc create sa ${sa_name} -n ${namespace}
oc get sa -n ${namespace}
oc describe sa ${sa_name}

oc policy -n glt-consul add-role-to-user view ${sa_name}
oc policy -n glt-consul add-role-to-user edit ${sa_name}

## Login with system admin user
oc login -u system:admin
oc adm policy add-scc-to-user anyuid -z ${sa_name}

# To give access to default service account
oc adm policy add-scc-to-user anyuid -z default

#oc adm policy add-scc-to-user anyuid -z admin

#######---------xxxx--------------xxx

## Login with system admin user
#oc login -u system:admin
#oc adm policy add-scc-to-user anyuid system:serviceaccount:${namespace}:${oc_user}
#oc adm policy add-scc-to-group nonroot system:serviceaccount:${namespace}:${oc_user}



#-- providing "view" role to service account for the project (examples of roles: admin, basic-user, edit, view, system:image-puller,system:image-pusher, system:image-builder)
## it will be visable on Security Group
#oc policy -n glt-consul add-role-to-user view ${oc_user}

#oc policy add-role-to-user view system:serviceaccount:${namespace}:${sa_name}
#oc policy add-role-to-user edit system:serviceaccount:${namespace}:${sa_name}

## For Security Group
#oc policy add-role-to-group edit system:serviceaccounts:${oc_user} -n ${namespace}
#$ oc policy add-role-to-group view system:serviceaccounts:${oc_user} -n ${namespace}
#oc get sa

#To allow all service accounts in all projects to view resources in the top-secret project:
#oc policy add-role-to-group view system:serviceaccount -n ${namespace}

#oc adm policy add-scc-to-user privileged -n ${namespace} -z ${sa_name}
#oc adm policy add-scc-to-user privileged system:serviceaccount:${sa_name}:registry
#oc adm policy add-scc-to-user privileged -n ${namespace} -z default
#=============================

##NOTE
##abc69de1-9eaf-465b-bb6c-1d317c4daf9a
#oc whoami
#system:admin
#echo -n 'abc69de1-9eaf-465b-bb6c-1d317c4daf9a' | base64
#YWJjNjlkZTEtOWVhZi00NjViLWJiNmMtMWQzMTdjNGRhZjlh

##Viewing Cluster Policy
#oc describe clusterPolicy default

### Full access to admin user
#oc adm policy add-cluster-role-to-user cluster-admin admin

##To check all the scc list of roles
#oc get scc

## To check role of scc
#oc get scc privileged

###To edit the scc privalged role from the policy
#oc edit scc privileged

##To edit all the scc roles like (restricted, privileged, nonroot, hostnetwork, hostmount-anyuid, hostaccess, anyuid)
#oc edit scc


#=============================

#-------------- [ Consul ] ----------------
## Creating Secret for Consul configuration of Token
oc login -u ${oc_user} -p ${oc_user}
oc create secret generic consul --from-file=consul-config/server.json -n ${namespace}
oc get secret -n ${namespace}

## Launching Consul Container through StatefulSet and making Consul service without Cluster IP.
oc get projects
oc project ${namespace}
oc create -n ${namespace} -f  consul-StatefulSet.yml

oc get pods -n ${namespace}	
oc get svc  -n ${namespace}		#To check Services
oc get StatefulSet -n ${namespace}
oc get ep -n ${namespace}	#To check End point 
#oc describe pods consul

## Creating service to access Consul UI
oc create -n ${namespace} -f  consul-service.yml

## Creating Secret to store ACL Token for Git2consul to access Consul UI.
oc create -n ${namespace} -f  consul-secret.yml


#-------------- [ git2consul ] ----------------
## Creating Configmap for git2consul to access json file in container
## To create config map for glt-consul env in git2consul-dev
oc create configmap git2consul-dev --from-literal=message='git2consul-dev' --from-file=glt-dev/config.json -n ${namespace}
oc create configmap git2consul-qa --from-literal=message='git2consul-qa' --from-file=glt-qa/config.json -n ${namespace}
oc get configmap -n ${namespace}
#oc delete configmap  --all # TO delete all config map

## Launching Git2consul Container through Deployment
oc create -n ${namespace} -f  glt-dev/git2consul.yml
oc create -n ${namespace} -f  glt-qa/git2consul.yml

#-------------------------