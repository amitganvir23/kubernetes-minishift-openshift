namespace=glt-dev
minikube ssh "ssh-keyscan github.com >> ~/.ssh/known_hosts; \
git clone https://github.com/amitganvir23/kubernetes-minishift-openshift.git; \
cd kubernetes-minishift-openshift/kubernetes/hello-app-run/helo-app-docker-image/; \
if [ ! -f id_rsa ];then echo File is missing id_rsa;pwd;exit 0;fi; \
chmod 600 id_rsa; \
docker build -t amitrepo/hellojava:0.0.1 ."