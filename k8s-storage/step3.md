# Step 3

# storage classes


Storage Classes replace PV's

list of SC: https://kubernetes.io/docs/concepts/storage/storage-classes/#provisioner



### local, used for deplay


```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: local-storage
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
```

and in the pvc, you add:

Spec.storageClassName: <name>


bound pvcs (to a sc) still showup in the get pv cmd

