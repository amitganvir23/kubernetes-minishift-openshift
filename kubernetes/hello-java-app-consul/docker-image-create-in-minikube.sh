namespace=glt-dev
dir=hello-app-docker-image
node_ip=$(minikube ip)

scp -i ~/.minikube/machines/minikube/id_rsa -r  $dir docker@${node_ip}:/home/docker/

minikube ssh "cd $dir; \
docker build -t amitrepo/envconsul-java-app-hello2:0.0.2 ."

#can do ssh
#$ ssh docker@192.168.99.100 -i ~/.minikube/machines/minikube/id_rsa
#$ ./envconsul -once -consul=192.168.99.100:30001 -prefix=glt-project/glt-dev/lmd-service/ -token=abc69de1-9eaf-465b-bb6c-1d317c4daf9a env