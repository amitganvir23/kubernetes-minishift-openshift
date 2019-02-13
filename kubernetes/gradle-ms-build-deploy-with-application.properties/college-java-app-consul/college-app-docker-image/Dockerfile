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
