## To create config map for glt-dev env in git2consul-dev
oc create configmap git2consul-dev --from-literal=message='git2consul-dev' --from-file=glt-dev/config.json -n glt-dev
#configmap "git2consul-dev" created

oc create configmap git2consul-qa --from-literal=message='git2consul-qa' --from-file=glt-qa/config.json -n glt-dev
#configmap "git2consul-qa" created

oc create configmap git2consul-consul --from-literal=message='git2consul-consul' --from-file=glt-consul/conf -n glt-dev
#configmap "git2consul-consul" created

oc get configmap -n glt-dev

#oc delete configmap  --all # TO delete all config map

