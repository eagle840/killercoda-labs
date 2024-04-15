
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

# Run First

`sudo apt update`{{exec}}



## Looks like we'll be using appsec.io at this point


`apt update`{{exec}}

`apt install -y nginx`{{exec}}

`nginx -v`{{exec}}

`wget https://downloads.openappsec.io/open-appsec-install && chmod +x open-appsec-install`{{exec}}

`./open-appsec-install -h`{{exec}}

`./open-appsec-install --auto`{{exec}}

`nginx -t`{{exec}}

`service nginx restart`{{exec}}

`nginx -t`{{exec}}

# https://docs.openappsec.io/getting-started/start-with-linux/using-the-open-appsec-ctl-tool

`open-appsec-ctl --list-policies`{{exec}}




--- modsecurity is end of life ---


To create a Dockerfile for running ModSecurity WAF (Web Application Firewall), you can follow the steps below:

1. Choose a base image: You can use a base image like `nginx` or `httpd` and then install ModSecurity on top of it.

2. Install ModSecurity: You can install ModSecurity using the package manager of the base image. For example, if you are using `nginx` as the base image, you can install ModSecurity using the following commands:

```Dockerfile
FROM nginx

RUN apt-get update && apt-get install -y libmodsecurity3
```

3. Configure ModSecurity: You will need to configure ModSecurity by providing the rules and configuration files. You can copy the configuration files and rules to the Docker image using the `COPY` command in the Dockerfile.

4. Update the nginx configuration: You will need to update the nginx configuration to enable ModSecurity. You can add the following lines to the nginx configuration file:

```Dockerfile
COPY modsecurity.conf /etc/nginx/modsecurity.conf
RUN echo "include /etc/nginx/modsecurity.conf;" >> /etc/nginx/nginx.conf
```

5. Expose the necessary ports: If ModSecurity is running as a reverse proxy, you will need to expose the necessary ports in the Dockerfile using the `EXPOSE` command.

6. Build the Docker image: Once you have created the Dockerfile, you can build the Docker image using the `docker build` command.

Here is an example Dockerfile for running ModSecurity WAF with nginx as the base image:

```Dockerfile
FROM nginx

RUN apt-get update && apt-get install -y libmodsecurity3

COPY modsecurity.conf /etc/nginx/modsecurity.conf
RUN echo "include /etc/nginx/modsecurity.conf;" >> /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```



Here is an example `modsecurity.conf` file that you can use with ModSecurity in the Dockerfile:

```conf
# ModSecurity Configuration

SecRuleEngine On
SecRequestBodyAccess On

SecAuditEngine RelevantOnly
SecAuditLog /var/log/modsec_audit.log

SecDebugLog /var/log/modsec_debug.log
SecDebugLogLevel 3

SecRule REMOTE_ADDR "@ipMatch 192.168.1.0/24" "id:1001,phase:1,deny,status:403,msg:'Access denied'"

Include /etc/nginx/modsecurity/*.conf
```

In this configuration file:
- `SecRuleEngine On` enables the ModSecurity rule engine.
- `SecRequestBodyAccess On` allows ModSecurity to access the request body.
- `SecAuditEngine RelevantOnly` specifies that only relevant requests should be logged.
- `SecAuditLog /var/log/modsec_audit.log` defines the path for the audit log file.
- `SecDebugLog /var/log/modsec_debug.log` and `SecDebugLogLevel 3` enable debug logging.
- `SecRule` defines a rule that denies access to requests coming from the specified IP range.
- `Include /etc/nginx/modsecurity/*.conf` includes additional configuration files from the specified directory.

You can customize this `modsecurity.conf` file further based on your specific requirements and rules. Make sure to place this file in the same directory as your Dockerfile or adjust the path in the Dockerfile accordingly.

  mkdir waf
    4  cd waf/
    5  touch Dockerfile
    6  nano Dockerfile
    7  docker build -t waf .
    8  touch modsecurity.conf
    9  nano modsecurity.conf
   10  nano Dockerfile
   11  docker build -t waf .
   12  docker imagines
   13  docker imagine
   14  docker -h
   15  docker images
   16  history

   docker run -d -p 80:80 waf  wip -d until fixed


apt-get install bison build-essential ca-certificates curl dh-autoreconf doxygen flex gawk git iputils-ping libcur14-gnutls-dev libexpat1-dev libgeoip-dev liblmdb-dev libpcre3-dev libpcre++-dev libssl-dev libtool libxm12 libxm12-dev libyajl-dev locales lua5.3-dev pkg-config wget zliblg-dev zlibc




--- remove below

# docker update

`apt-get remove docker  docker.io containerd runc -y`{{exec}}

`apt-get update`{{exec}}

`apt-get install ca-certificates curl gnupg  lsb-release -y`{{exec}}

`mkdir -p /etc/apt/keyrings`{{exec}}

`curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg`{{exec}}

```
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```{{exec}}

`apt-get update`{{exec}}

`apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y `{{exec}}

`docker version`{{exec}}

`docker-compose version`{{exec}}

`docker compose version`{{exec}}

# Set imageid in index.json

- ubuntu: Ubuntu 20.04 with Docker and Podman
= kubernetes-kubeadm-2nodes:
- kubernetes-kubeadm-1node:

to taint the control node for work:

```
kubectl taint nodes controlplane node-role.kubernetes.io/master:NoSchedule-
kubectl taint nodes controlplane node-role.kubernetes.io/control-plane:NoSchedule-
```


# Copy Files/adjust index

text here

# Run apt update

apt-get update -y{{execute}}

```apt-get update -y{{execute}}```


# For links to ports:

```
Link for traffic into host 1 on port 80
{{TRAFFIC_HOST1_80}}
Link for traffic into host 2 on port 4444
{{TRAFFIC_HOST2_4444}}
Link for traffic into host X on port Y
{{TRAFFIC_HOSTX_Y}}
```


# Example setup for postgres with raw data

git clone https://github.com/josephmachado/simple_dbt_project.git

- raw folders
- warehouse setup
- docker postgres and -v to those folders


We'll be using the rabbitmq container with the management feature installed.

https://hub.docker.com/_/rabbitmq

`docker run -d --hostname my-rabbit --name some-rabbit -p 8080:15672 rabbitmq:3-management`{{execute}}

make sure it started

`docker ps`{{execute}}

and check the config file

`docker exec some-rabbit cat /etc/rabbitmq/rabbitmq.conf`{{execute}}

and head over to port 8080 and login
un:guest
pw:guest


Next we'll update the python files with the new IP address of the docker container.

`RabbitIP=$(docker inspect some-rabbit | jq -r .[0].NetworkSettings.IPAddress)`{{execute}}

`echo $RabbitIP`{{execute}}

`sed -i "s/localhost/$RabbitIP/g" send.py receive.py worker.py new_task.py`{{execute}}

## k8s port-forward

`k -n <ns> port-forward service/<svc-name> 9090:9090 --address 0.0.0.0`

- this is to forword a CLusterIP so that killacoda can access


`echo 'PATH=$PATH':$(pwd)/bin >> /root/.bashrc`{{copy}}

export PATH=$PWD/bin:$PATH

to allow pods on the controlplane

`kubectl taint node controlplane node-role.kubernetes.io/master:NoSchedule-`{{copy}}

to allow access to running pods with ports 9000 and 9090

`kubectl port-forward -n minio-dev pod/minio 9000 9090 --address 0.0.0.0`{{copy}}
