#!/bin/sh
set -x
# $SERVER_PORT value take from Consul URL
java -Dserver.port=${SERVER_PORT} -jar /myapp/app.jar