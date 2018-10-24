oc login -u system:admin
oc adm policy add-scc-to-user nonroot admin
oc adm policy add-scc-to-group nonroot admin
oc create serviceaccount admin glt-dev
oc adm policy add-scc-to-group anyuid system:authenticated
oc adm policy add-scc-to-user anyuid system:serviceaccount:glt-dev:admin
oc adm policy add-scc-to-user anyuid system:serviceaccount:glt-consul:admin
oc adm policy add-scc-to-user anyuid system:serviceaccount:nginx:admin
oc adm policy add-scc-to-user anyuid system:serviceaccount:glt-qa:admin
oc adm policy add-scc-to-user anyuid system:serviceaccount:glt-test:admin
oc adm policy add-scc-to-user anyuid -z default
