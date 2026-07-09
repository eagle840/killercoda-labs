# Step 2: Baseline Inference

Deploy a tiny CPU inference container to test base model functionality and verify service exposure.

`touch phi-4-workspace.yaml`{{exec}}


```yaml
apiVersion: kaito.sh/v1beta1
kind: Workspace
metadata:
  name: workspace-phi-4-mini
resource:
  labelSelector:
    matchLabels:
      apps: llm-inference
inference:
  preset:
    name: phi-4-mini-instruct
```{{copy}}

`kubectl apply -f phi-4-workspace.yaml`{{exec}}