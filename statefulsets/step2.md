
There are three main things to configure for a statefulSet, provision the PV's, setup a headless service and setup a STS deployment


# Setup the PV's

for this lab we'll setup 5 PV's (pv0 -> pv5)
we'll need the IP of the nfs server, which we got in the previous step: NFSIP.

copy below into pvX.yaml (copy:ctrl-insert, past:shft-insert, save:ctrl-o, exit:ctrl-x)

`nano pvX.yaml`{{execute}}

```
apiVersion: v1
kind: PersistentVolume
metadata:
   name: pv-nfs-pvX
   labels:
     type:  local
spec:
   storageClassName:  manual
   capacity:
      storage: 200Mi
   accessModes:
      - ReadWriteOnce
   nfs:
      server: serverIP   # nfs server address
      path: "/srv/nfs/kubedata/pvX"
```{{copy}}


Lets replace serverIP with the real NFS server address:

`sed -i "s/serverIP/$NFSIP/" pvX.yaml`{{execute}} 

and confirm:

`cat pvX.yaml`{{execute}}

Now with this default yaml file, we'll create a yaml for each PV with a small script.

`for var in 0 1 2 3 4; do  sed "s/pvX/pv$var/g" pvX.yaml > pv$var.yaml ; done `{{execute}}

`ls`{{execute}}

and create them:

`for var in 0 1 2 3 4; do k create -f pv$var.yaml; done`{{execute}}

`k get pv`{{execute}}

# Setup the Headless service

note in the following yaml, that clusterIp is 'None', and that you''l have to create a seperate service for access.

`nano headless.yaml`{{execute}}

```
apiVersion: v1
kind: Service
metadata:
   name: nginx-headless
   labels:
      run: nginx-sts-demo
spec:
   ports:
   - port: 80
     name: web
   clusterIP:  None
   selector:
     run:  nginx-sts-demo
```{{copy}}

`k create -f headless.yaml`{{execute}}

`k get service`{{execute}}

# Setup application

note the volume claim templete used in this sts, it will setup the volumes

`nano sts.yaml`{{execute}}

```
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: nginx-sts
spec:
  serviceName: "nginx-headless"
  replicas: 2
  #podManagementPolicy: Parallel
  selector:
    matchLabels:
      run: nginx-sts-demo
  template:
    metadata:
      labels:
        run: nginx-sts-demo
    spec:
      containers:
      - name: nginx
        image: nginx
        volumeMounts:
        - name: www
          mountPath: /var/www/
  volumeClaimTemplates:
  - metadata:
      name: www
    spec:
      storageClassName: manual
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: 100Mi
```{{copy}}


`k create -f sts.yaml`{{execute}}

`k get sts`{{execute}}

You'll notice in the yaml, it's only going to create 2 replicas

`k get pods`{{execute}}

note the pod names are `<statefulset name>-<ordinal index>`

Wait a minute or two for the pods to come fully up.



Lets scale up the replicas and see what happens:

`k scale --replicas=3 sts/nginx-sts`{{execute}}

`k get sts`{{execute}}

`k get pods`{{execute}}




