# kubernetes-minishift-openshift
#####[jenkins@ip-172-168-0-148 ~]$ uuidgen
- 17dd6a1b-a963-4ad1-bfd1-2610375a7fc9

## Shell scripting
#### To start git2consul pod 			- create_git2consul.sh
#### To start consul pod + namespace	- create_consul.sh
#### To start git2consul pod 			- create_git2consul.sh

#### To Create git2consul docker image	- gitconsul-docker-image.sh

#### To remove consul		- remove_consul.sh
#### To remove envconsul	- remove_git2consul.sh

#### Following variable using in script:
	namespace=glt-consul
	sa_name=consul-serviceaccount
	acl_token=consul-token
	config_acl=consul
	config_dev=git2consul-dev
	config_qa=git2consul-qa


## yaml file
#### To create namespace in k8s - create_namespace.yml
#### To create secrets in k8s - creconsul-secret.yml
#### To create servcie in k8s - consul-service.yml
#### To create deployment in k8s - consul-StatefulSet.yml

#### To create deployment in k8s - glt-dev/git2consul.yml	(configured glt-dev branch and repo to update values in consul)
#### To create deployment in k8s - glt-qa/git2consul.yml	(configured glt-qa branch and repo to update values in consul)