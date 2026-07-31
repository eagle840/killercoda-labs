# Step 4: Expose Service

To access Flowise, we will use Kubernetes port-forwarding.

Execute the following to expose the service to your local machine:

```bash
kubectl port-forward svc/flowise 3000:3000 --address 0.0.0.0
```{{exec}}

connect to port 3000 {{TRAFFIC_HOST1_3000}}

use the following in the web portal to setup the admin

un:`admin`   
email: `admin@example.com`   
pw: `Pa55w@rd`     
