# review

### type of ....

- stdin #0
- stdout #1
- stderr #2

# apps can send logs too:

- STDERR
- Own logs (EG apache)
- rsyslog
- systemd-journald

# log formats

- syslog protocol
  - inc's facility and severity codes

/var/log/<service>

`cat /var/log/syslog`{{exec}}
 - alot of diirent things

`ls /var/log`{{exec}}
 - syslogs  gets rotated  *<#>.gz

`cat /var/log/dmesg`{{exec}}
- hw and kernal
- just use

`dmesg`{{exec}}

- you can use head and tail for the logs with the -f flag
- use `tail -f /var/log/syslog` when troubleshooting a service

- auth.log for authN and authZ logs, grep -e 'failon'

'last' shows the last login/out
 - which uses /var/log/wtmp # a binary file

`lastb`

`lastlog - u <usrname>` # last login of user

`who` # who is logged in,  `whowatch`

`netstat -tulpn`{{exec}}

ifconfig is depricated, use `ipaddr`

service config is usually stored in

/etc/<servic>/conf.d

# systemctl

systemctl <cmd> <service/unit> <options>

cmds: status, start, stop, disable, enable, list-units, daemon-reload

options: --type=[servive|?]



# journalctl

- powered by systemd

`journalctl -u ssh`{{exec}}
-u unit, which is ssh
- there is  a search mode

#  list process'

ps -aux

ps -eaf | grep elasticsearch

? how to restarrt a service without systemctl (for docker as well)





##################  delete below  ##################

# Initial Setup

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

https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com

Next we'll update the python files with the new IP address of the docker container.

`RabbitIP=$(docker inspect some-rabbit | jq -r .[0].NetworkSettings.IPAddress)`{{execute}}

`echo $RabbitIP`{{execute}}

`sed -i "s/localhost/$RabbitIP/g" send.py receive.py worker.py new_task.py`{{execute}}

