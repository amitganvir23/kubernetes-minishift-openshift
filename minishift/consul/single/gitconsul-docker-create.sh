namespace=glt-dev
ssh-keyscan github.com >> ~/.ssh/known_hosts
git clone https://github.com/amitganvir23/kubernetes-minishift-openshift.git
cd kubernetes-minishift-openshift/minishift/consul/git2consul-docker-image/${namespace}
if [ ! -f id_rsa ];then echo File is missing id_rsa;pwd;exit 0;fi
docker build -t amitrepo/git2consul-${namespace}:0.12.13 .
