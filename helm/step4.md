# generate from scratch


`helm create my-app`{{execute}}

`cd my-app`{{execute}}

lets remove files we don't need

`rm ./templates/*`{{execute}}

`echo "" > values.yaml` {{execute}}

### Bare template

lets get a template from https://k8syaml.com/, just copy the default template will be fine. (you can remove the pod affinity if you wish. Use the copy function in the top right)

can paste it into the templates folder

`nano ./templates/app.yaml`{{execute}}

Now since there is no templating, the yaml file generated will only have comments inserted

`helm template .`{{execute}}

### Add a value for the template

`echo  "replicas:2 " >> values.yaml`{{execute}}

and in the template/app.yaml file, change the replicas line to {{.Values.replicas}}


`nano ./templates/app.yaml`{{execute}}

and lets see the generated output:

`helm template .`{{execute}}

=============================================


`nano ./templates/deployment.yaml`{{execute}}


paste the following:

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Values.postgres.name }}
  labels:
    app: {{ .Values.postgres.name }}
    group: {{ .Values.postgres.group }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: {{ .Values.postgres.name }}
  template:
    metadata:
      labels:
        app: {{ .Values.postgres.name }}
        group: {{ .Values.postgres.group }}
    spec:
      volumes:
        - name: {{ .Values.postgres.volume.name }}
          persistentVolumeClaim:
            claimName: {{ .Values.postgres.volume.pvc.name }}
      containers:
        - name: {{ .Values.postgres.name }}
          image: {{ .Values.postgres.container.image }}  
          ports:
            - containerPort: {{ .Values.postgres.container.port }}
          envFrom:
            - configMapRef:
                name: {{ .Values.postgres.config.name }}
          volumeMounts:             
            - name: {{ .Values.postgres.volume.name }}
              mountPath: {{ .Values.postgres.volume.mountPath }} 
```