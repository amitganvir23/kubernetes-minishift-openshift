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

## Deleting all the resource of Consul and git2consul
oc delete -f consul-StatefulSet.yml -n ${namespace}
oc delete -f consul-service.yml -n ${namespace}

oc delete -f glt-dev/git2consul.yml -n ${namespace}
oc delete -f glt-qa/git2consul.yml -n ${namespace}

oc delete sa ${sa_name} -n ${namespace}

## Deleting Consul Token and Configuration Token file
oc delete secrets -n ${namespace} ${acl_token}
oc delete secrets -n ${namespace} ${config_acl}

## Deleting configmap
oc delete configmap -n ${namespace} ${config_dev}
oc delete configmap -n ${namespace} ${config_qa}

## It will create service account to access API's
oc delete sa ${sa_name} -n ${namespace}

#--- Reomving roles from policy
## Reomving view and edit role from policy for project/namespace
oc policy -n ${namespace} remove-role-to-user view ${sa_name}
oc policy -n ${namespace} remove-role-to-user edit ${sa_name}

## Login with system admin user
oc login -u system:admin
oc adm policy remove-scc-to-user anyuid -z ${sa_name}

# To give access to default service account
oc adm policy remove-scc-to-user anyuid -z default
#oc adm policy remove-scc-to-user anyuid -z admin


oc delete project ${namespace}
###==============
#Note:

##To check all the scc list
#oc get scc

###To edit the scc privalged role from the policy
#oc edit scc privileged

##To edit all the scc roles like (restricted, privileged, nonroot, hostnetwork, hostmount-anyuid, hostaccess, anyuid)
#oc edit scc
#===========





