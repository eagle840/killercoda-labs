# Deploy to k8s with Yatai


https://github.com/bentoml/Yatai



confirm k8s is up:

`kubectl cluster-info`{{exec}}

WIP: untaint master?


prereq:


# postresql

`mkdir pgsql && cd pgsql`{{exec}}

`nano docker-compose.yaml`{{exec}}

```yaml
version: '3.8'
services:
  db:
    image: postgres:14.1-alpine
    restart: always
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres
    ports:
      - '5432:5432'
    volumes: 
      - db:/var/lib/postgresql/data
volumes:
  db:
    driver: local
```

`wget https://github.com/kubernetes/kompose/releases/download/v1.26.1/kompose_1.26.1_amd64.deb`{{exec}}


`sudo apt install ./kompose_1.26.1_amd64.deb`{{exec}}

`kompose convert -f docker-compose.yaml`{{exec}}

`k apply -f .`{{exec}}



## update helm:

WIP CREATE storage clasess' for postsql


`wget https://get.helm.sh/helm-v3.10.1-linux-amd64.tar.gz`{{exec}}

`tar -zxvf helm-v3.10.1-linux-amd64.tar.gz `{{exec}}

`helm version`{{exec}}


`which helm`{{exec}}

`mv linux-amd64/helm /usr/bin/helm`{{exec}}

`helm version`{{exec}}



## WIP CREATE storage clasess' for postsql

Install nfs and start the server

`apt install nfs-kernel-server --fix-missing -y`{{execute}}

`systemctl enable nfs-server`{{execute}}

`systemctl start nfs-server`{{execute}}

`systemctl status nfs-kernel-server`{{execute}} 


Setup some share folders:

`mkdir -p /srv/nfs/kubedata`{{execute}}

`mkdir /srv/nfs/kubedata/{pv0,pv1,pv2,pv3,pv4}`{{execute}}

`chmod -R 777 /srv/nfs`{{execute}}

Update the nfs share configuration:

`echo "/srv/nfs/kubedata    *(rw,sync,no_subtree_check,insecure)" >> /etc/exports`{{execute}}


`exportfs -rav`{{execute}}

`exportfs -v`{{execute}}

`showmount -e`{{execute}}


And let's set an env for the nfs server which we'll use in the next steps.
`ip addr | grep ens3`{{execute}}

`NFSIP=$(ip addr show enp1s0  | awk '$1 == "inet" { print $2 }' | cut -d/ -f1)`{{execute}}

`echo $NFSIP`{{execute}}

#### TEST NFS 
Connect to node01 and test the mount for nfs share (type yes when prompted)

`ssh root@node01 apt install nfs-common -y`{{exec}}

`ssh root@node01 mount -t nfs $NFSIP:/srv/nfs/kubedata  /mnt`{{execute}}

`ssh root@node01 ls /mnt  # show see pv0->4`{{execute}}

And ummount the share
`ssh root@node01 umount /mnt`{{execute}}

## Install Yatai

install Yatai (fails due to postsql prereq)

`DEVEL=true bash <(curl -s "https://raw.githubusercontent.com/bentoml/yatai/main/scripts/quick-install-yatai.sh")`{{exec}}







In a seperate terminal:

```bash
YATAI_INITIALIZATION_TOKEN=$(kubectl get secret env --namespace yatai-system -o jsonpath="{.data.YATAI_INITIALIZATION_TOKEN}" | base64 --decode)
echo "Open in browser: http://127.0.0.1:8080/setup?token=$YATAI_INITIALIZATION_TOKEN"
```((exec))


goto http://127.0.0.1:8080/api_tokens  at the following link:
{{TRAFFIC_HOST1_3000}}


`bentoml yatai login --api-token {YOUR_TOKEN} --endpoint http://127.0.0.1:8080`{{exec}}

`bentoml push iris_classifier:latest`{{exec}}

```bash
DEVEL=true bash <(curl -s "https://raw.githubusercontent.com/bentoml/yatai-deployment/main/scripts/quick-install-yatai-deployment.sh")
```{{exec}}

goto http://127.0.0.1:8080/deployments and click 'create' and follow the instructions


The github page also includes instructions for deploying through CRD


### BentoMLctl

consider fro deployment to a cloud provider
https://github.com/bentoml/bentoctl