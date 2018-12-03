# kube-nginx-proxy
![latest 0.1.3](https://img.shields.io/badge/latest-0.1.3-green.svg?style=flat)
![nginx 1.11.8](https://img.shields.io/badge/nginx-1.11.8-brightgreen.svg?style=flat)
![License BSD](https://img.shields.io/badge/license-BSD-red.svg?style=flat)
[![](https://img.shields.io/docker/stars/kylemcc/kube-nginx-proxy.svg?style=flat)](https://hub.docker.com/r/kylemcc/kube-nginx-proxy 'DockerHub')
[![](https://img.shields.io/docker/pulls/kylemcc/kube-nginx-proxy.svg?style=flat)](https://hub.docker.com/r/kylemcc/kube-nginx-proxy 'DockerHub')

`kube-nginx-proxy` is a Docker container running nginx and [kube-gen][1]. `kube-gen` watches for events on the Kubernetes API and generates nginx server blocks and reverse proxy configurations for Kubernetes Services and Pods as they are started and stopped.

## Usage

The recommended way to run `kube-nginx-proxy` is as a [Daemon Set][2] in your cluster. You may choose to run kube-nginx-proxy on all nodes, or on a subset of nodes in your cluster. A sample Daemon Set spec appears below (as well as [here][3]):

```yaml
apiVersion: extensions/v1beta1
kind: DaemonSet
metadata:
  name: "kube-nginx-proxy"
  labels:
    app: "kube-nginx-proxy"
    version: "0.1.3"
  namespace: "dev"
  annotations:
    description: "nginx reverse proxy for services and pods powered by annotations"
spec:
  template:
    metadata:
      labels:
        app: "kube-nginx-proxy"
    spec:
      hostNetwork: true
      # use a nodeSelector to control where pods are scheduled
      # e.g., specify a hostname to run on a single host, or a label to run on a specific group of hosts
      #nodeSelector:
      #  kubernetes.io/hostname: <host>
      #  <label_name>: <label_value>
      containers:
        -
          name: "kube-nginx-proxy"
          image: "kylemcc/kube-nginx-proxy:0.1.3"
          resources:
            requests:
              cpu: "100m"
              memory: "256Mi"
          ports:
            -
              containerPort: 80
              hostPort: 80
            -
              containerPort: 443
              hostPort: 443
          imagePullPolicy: "Always"
          securityContext:
            privileged: true
      restartPolicy: "Always"
      terminationGracePeriodSeconds: 30
```

### Configuration

Annotations are used to discover Pods and Services and configure reverse proxy settings. Currently, the following annotations are supported:

- **proxy_host**: (required) The target hostname for the reverse proxy. Requests to this hostname will be routed to the corresponding Pod/Service. Multiple hostnames may be provided as a comma-separated string.
- **proxy_port**: (default: 80) The Pod/Service port to which requests should be proxied. Only one port per Pod/Service is supported. If more than one port is required (e.g., for a pod running multiple containers), separate Services should be created with distinct proxy_host/proxy_port combinations.
- **proxy_proto**: (default: http) The protocol over which requests should be proxied. `http` and `https` are supported.


See below for example Service and Pod definitions:

Pod:

```yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    proxy_host: logstash.foo.com
    proxy_port: 5044
  labels:
    app: logstash
  name: logstash
spec:
  containers:
    - image: logstash:2.3.4
      name: logstash
      ports:
        - containerPort: 5044
          protocol: TCP
```

Service:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: "elasticsearch"
  labels:
    app: "elasticsearch"
  annotations:
    proxy_host: search.foo.com
    proxy_port: 80 # should be the same as the service port
spec:
  ports:
    - port: 80
      targetPort: 9200
      protocol: TCP
      name: http
    - port: 9300
      targetPort: 9300
      protocol: TCP
      name: transport
  selector:
    app: elasticsearch
```

### Custom nginx Configuration

The default nginx and proxy configurations can be easily overridden with using a [ConfigMap][4] containing
a custom configuration and specifying the [subPath][5] option in the volumeMount.  E.g.:

ConfigMap specifying a custom nginx.conf and proxy.conf:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-proxy-conf-v1
data:
  proxy.conf: |-
    # HTTP 1.1 support
    proxy_http_version 1.1;
    proxy_buffering off;
    proxy_set_header Host $http_host;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection $proxy_connection;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $proxy_x_forwarded_proto;
    proxy_read_timeout 10m;
    client_max_body_size 25m;
  nginx.conf: |-
    user  nginx;
    worker_processes  2;
    daemon off;
    
    error_log  /var/log/nginx/error.log warn;
    pid        /var/run/nginx.pid;
    
    
    events {
        worker_connections  1024;
        multi_accept on;
    }
    
    
    http {
        server_names_hash_bucket_size 128;
        include       /etc/nginx/mime.types;
        default_type  application/octet-stream;
    
        log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                          '$status $body_bytes_sent "$http_referer" '
                          '"$http_user_agent" "$http_x_forwarded_for"';
    
        access_log  /var/log/nginx/access.log  main;

        sendfile        on;
        keepalive_timeout  65;
        gzip  on;
        include /etc/nginx/conf.d/*.conf;
    }
```

Volume configuration:

```yaml
apiVersion: extensions/v1beta1
kind: DaemonSet
spec:
  template:
    spec:
      containers:
        -
          name: "kube-nginx-proxy"
          image: "kylemcc/kube-nginx-proxy:0.1.3"
          volumeMounts:
            - name: nginx-proxy-config
              mountPath: /etc/nginx/proxy.conf
              subPath: proxy.conf
            - name: nginx-proxy-config
              mountPath: /etc/nginx/nginx.conf
              subPath: nginx.conf
      volumes:
        - name: nginx-proxy-config
          configMap:
            name: nginx-proxy-conf-v1
```

### TODO

- SSL Support
- TCP/UDP Proxying?
- Session Affinity Support

[1]: https://github.com/kylemcc/kube-gen
[2]: http://kubernetes.io/docs/admin/daemons/
[3]: https://github.com/kylemcc/kube-nginx-proxy/blob/master/kube-nginx-proxy-daemonset.yaml
[4]: http://kubernetes.io/docs/user-guide/configmap/
[5]: http://kubernetes.io/docs/user-guide/volumes/#using-subpath
