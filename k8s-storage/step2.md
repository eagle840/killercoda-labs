# Hello World! using python




# pvc

pvc are bound to namespaces

```
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: claim-log-1
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 50Mi
```

`k get pvc`{{exec}}

update the pod

```yaml
  volumes:
  - name: log-volume
    persistentVolumeClaim:
      claimName: claim-log-1
```



