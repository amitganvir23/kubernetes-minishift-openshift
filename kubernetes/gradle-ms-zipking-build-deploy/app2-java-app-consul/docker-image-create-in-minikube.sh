namespace=glt-dev
appname=app2
dir=app2-app-docker-image
node_ip=$(minikube ip)

cp -r ../gradle-build-code/${appname}/build/libs/${appname}-0.0.1-SNAPSHOT.jar ${dir}/app.jar
scp -i ~/.minikube/machines/minikube/id_rsa -r  $dir docker@${node_ip}:/home/docker/

minikube ssh "cd $dir; \
docker build -t amitrepo/envconsul-java-app-app2:0.0.2 ."

