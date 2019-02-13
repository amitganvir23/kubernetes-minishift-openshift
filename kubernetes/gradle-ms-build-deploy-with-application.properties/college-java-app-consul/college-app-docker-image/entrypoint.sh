#!/bin/sh
set -x

# $SERVER_PORT value take from Consul URL

#java -Dserver.port=${SERVER_PORT} -jar /myapp/app.jar
#exec gosu app $java_cmd $JAVA_AGENT_OPTIONS $JAVA_OPTIONS -DCONSUL_TOKEN=${CONSUL_TOKEN} -DSPRING_CLOUD_CONSUL_TOKEN=${CONSUL_TOKEN} -Dspring.cloud.consul.config.acl-token=${CONSUL_TOKEN} -Dspring.cloud.consul.config.watch.enabled=true -Dspring.cloud.consul.config.watch.delay=300000 -Dspring.cloud.consul.config.prefix=${PREFIX_MAIN} -Dspring.cloud.consul.host=${CONSUL_URL} -Dspring.cloud.consul.port=${CONSUL_PORT} -Dconfig.home=/opt/apps/config -Denv=${APP_ENV} -jar /opt/scratch/jars/app.jar $APP_OPTIONS

CONSUL_TOKEN="abc69de1-9eaf-465b-bb6c-1d317c4daf9a"
CONSUL_URL="192.168.99.100"
CONSUL_PORT="30001"
PREFIX_MAIN="glt-project/glt-dev/hello2-service"
#-Denv=${APP_ENV}

java -DCONSUL_TOKEN=${CONSUL_TOKEN} -DSPRING_CLOUD_CONSUL_TOKEN=${CONSUL_TOKEN} -Dspring.cloud.consul.config.acl-token=${CONSUL_TOKEN} -Dspring.cloud.consul.config.watch.enabled=true \
-Dspring.cloud.consul.config.prefix=${PREFIX_MAIN} -Dspring.cloud.consul.host=${CONSUL_URL} -Dspring.cloud.consul.port=${CONSUL_PORT} \
-jar /myapp/app.jar