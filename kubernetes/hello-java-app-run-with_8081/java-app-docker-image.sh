namespace=glt-dev
minikube ssh "ssh-keyscan github.com >> ~/.ssh/known_hosts; \
git clone https://github.com/amitganvir23/kubernetes-minishift-openshift.git; \
cd kubernetes-minishift-openshift/kubernetes/hello-app-run/helo-app-docker-image/; \
docker build -t amitrepo/hellojava:0.0.1 ."

#can do ssh
#$ ssh docker@192.168.99.100 -i ~/.minikube/machines/minikube/id_rsa
#scp -i ~/.minikube/machines/minikube/id_rsa build/libs/hello-0.0.1-SNAPSHOT.jar  docker@192.168.99.100:/home/docker/hello.jar
