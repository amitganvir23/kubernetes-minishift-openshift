FROM anapsix/alpine-java:8_jdk_nashorn

RUN mkdir /opt/myapp

COPY entrypoint.sh /opt/myapp

COPY hello.jar /opt/myapp/app.jar

RUN chmod +x /opt/myapp/entrypoint.sh

ENTRYPOINT ["/opt/myapp/entrypoint.sh"]
