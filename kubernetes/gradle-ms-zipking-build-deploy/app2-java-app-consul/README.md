####
envconsul version: 0.6.1
consul version: 1.0.2
##1) Download: envconsul command from URL "https://releases.hashicorp.com/envconsul/0.6.1/envconsul_0.6.1_linux_386.zip" and extract in directory "hello-app-docker-image".


### 2) how envconsul work with consul kv.
It get all variable values from consul by envconsul command, just need to follow the below syntax.
Syntax: envconsul -once -consul=<IP>:<PORT>/FQDN -prefix=<Key_dir_path> -token=<Consul_TOKEN> <Command/script>

It should work. What versions of the tools are you running?

Here's my duplication, with `consul agent -dev -server` running in a second window:

    $ consul version
    Consul v0.7.5
    Protocol 2 spoken by default, understands 2 to 3 (agent will automatically use protocol >2 when speaking to compatible agents)

    $ envconsul --version
    envconsul v0.6.2 (ddf8503)

    $ consul kv put test/cass_test false
    Success! Data written to: test/cass_test

    $ consul kv get test/cass_test
    false

    $ consul kv get -recurse test
    test/cass_test:false

    $ envconsul -prefix=test env |grep cass_test
    cass_test=false

    $ envconsul -prefix=test /bin/bash -c 'echo $cass_test'
    false
	
	### minikube/kubernetes
	It will print all the variable including from consul
	$ ./envconsul -once -consul=192.168.99.100:30001 -prefix=glt-project/glt-dev/lmd-service/ -token=abc69de1-9eaf-465b-bb6c-1d317c4daf9a env
	$ /usr/bin/envconsul -once -consul=192.168.99.100:30001 -prefix=glt-project/glt-dev/hello2-service/ -token=abc69de1-9eaf-465b-bb6c-1d317c4daf9a env
	It will print value of the variabel from Consul.
	./envconsul -once -consul=192.168.99.100:30001 -prefix=glt-project/glt-dev/lmd-service/ -token=abc69de1-9eaf-465b-bb6c-1d317c4daf9a  /bin/bash -c 'echo $SERVER_PORT'

#### Docker for creating docerk image
#-----------
# original image: https://github.com/Cimpress-MCP/docker-git2consul
FROM anapsix/alpine-java:8_jdk_nashorn

RUN mkdir /myapp

COPY entrypoint.sh /myapp/
COPY envconsul /usr/bin/
COPY hello.jar /myapp/app.jar

RUN chmod +x /myapp/entrypoint.sh
RUN chmod +x /usr/bin/envconsul

CMD envconsul -once \
-consul=192.168.99.100:30001 -prefix=glt-project/glt-dev/hello2-service -token=abc69de1-9eaf-465b-bb6c-1d317c4daf9a \
/myapp/entrypoint.sh
#-----------

#### entrypoin.sh
#-----------
#!/bin/sh
set -x
# $SERVER_PORT value take from Consul URL
java -Dserver.port=${SERVER_PORT} -jar /myapp/app.jar
#-----------


## Shell scripting
#### To start java deployment from k8s 				- start_app.sh

#### To Create java app with envconsul docker image	- docker-image-create-in-minikube.sh

#### To remove java deployment from k8s				- remove_app.sh

#### Following variable using in script:

Specify your container port number in Consul KV and in k8s yaml file (hello-app-deploy.yml) as well.
