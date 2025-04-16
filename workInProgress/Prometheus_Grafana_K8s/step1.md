# INTRO


## Comparison of Log and Analytics Stacks by Key Components

| **Stack**       | **Database**      | **Data Collection** | **Visualization** |
|------------------|-------------------|---------------------|-------------------|
| **ELK**          | Elasticsearch     | Logstash            | Kibana            |
| **EFK**          | Elasticsearch     | Fluentd             | Kibana            |
| **TICK**         | InfluxDB          | Telegraf            | Chronograf        |
| **Prometheus & Grafana** | Prometheus | Exporters           | Grafana           |



In this lab we will install an Prometheous/Grafana stack on a k8s cluster

WIP - create storaege

Docs and sources:


Run Ubuntu updates:

`apt-get update -y`{{execute}}

`apt install -y tree jq`{{execute}}

`kubectl cluster-info`{{exec}}

WIP: de-taint controlnode

## setup storage

`apt install nfs-kernel-server --fix-missing -y`{{exec}}

`systemctl enable nfs-server`{{exec}}

`systemctl start nfs-server`{{exec}}

`systemctl status nfs-kernel-server`{{exec}}


`mkdir -p /mnt/nfs/promdata`{{exec}}

WIP `chmod -R 777 /mnt/nfs`{{copy}}

WIP `chmod -R 777 /mnt/nfs/promdata`{{copy}}

`echo "/mnt/nfs/promdata *(rw,sync,no_subtree_check,insecure)" >> /etc/exports`{{exec}}


`exportfs -rav`{{exec}}

`exportfs -v`{{exec}}


`showmount -e`{{exec}}

`ssh root@node01 apt install nfs-common -y`{{exec}}

`NFSIP=$(ip addr show enp1s0  | awk '$1 == "inet" { print $2 }' | cut -d/ -f1)`{{exec}}

`echo $NFSIP`{{exec}}

`ssh root@node01 mount -t nfs $NFSIP:/mnt/nfs/promdata  /mnt`{{exec}}

`ssh root@node01 ls /mnt`{{execute}}

And ummount the share
`ssh root@node01 umount /mnt`{{execute}}

   

## setup prometheous

`mkdir pg && cd pg`{{exec}}

### create a name space

`nano logging_ns.yaml`{{exec}}

```
kind: Namespace
apiVersion: v1
metadata:
  name: monitoring
```


`wget https://gist.githubusercontent.com/gurpreet0610/05c4dc50e641fe0b3c23b36d491be8f5/raw/5c6baf70946a3b0e597154830c9b4015e25e5b9e/prometheus-config.yaml`{{exec}}



`k apply -f prometheus-config.yaml `{{exec}}


### storage

pv:

`wget https://gist.github.com/gurpreet0610/49bdf326a8f493a992d4649dfdc4b00a/raw/523631233d4821fb81dfa22491a40d22c8a26c73/prometheus-pv-nfs.yaml`{{exec}}

pvc: WIP{ CHANGE IP} in ABOVE:

`wget https://gist.github.com/gurpreet0610/e5deced18b97cd6744a6573f0ab4a1be/raw/a4a93bb7f80e398ba749d6da93a6c2d0bf21e024/prometheus-pvc-nfs.yaml`{{exec}}

WIP: fix the pv, and then apply the 2 above

`k apply -f prometheus-pv-nfs.yaml `{{exec}}

`k get pv`{{exec}}

`k apply -f prometheus-pvc-nfs.yaml`{{exec}}

`k get pvc -A`{{exec}}

### deploy

`wget https://gist.github.com/gurpreet0610/c5fbb8cd276a680227216ce07819cebc/raw/05203d72afe9bc97c1378e265bae2437ec55d366/prometheus-deployment.yaml`{{exec}}


`k apply -f prometheus-deployment.yaml `{{exec}}

`k get pods -A`{{exec}}

`wget https://gist.github.com/gurpreet0610/27bb281bb202f0a8dbb4fda6f0100f29/raw/a1c8459eb96ad7d5a4adbb53ea08585e252b5f28/prometheus-service.yaml`{{exec}}

`k apply -f prometheus-service.yaml`{{exec}}

`k get svc -A`{{exec}}


connect to 30000 on the node 2