namespace=glt-dev
appname=college
dir=college-app-docker-image
node_ip=$(minikube ip)

cp -r ../gradle-build-code/college/build/libs/${appname}-0.0.1-SNAPSHOT.jar ${dir}/${appname}.jar
scp -i ~/.minikube/machines/minikube/id_rsa -r  $dir docker@${node_ip}:/home/docker/

minikube ssh "cd $dir; \
docker build -t amitrepo/envconsul-java-app-college:0.0.2 ."

