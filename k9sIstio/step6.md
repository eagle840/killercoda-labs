Step 6: Monitoring and Observability with K9s

In this step, you will install K9s, a Kubernetes CLI tool for managing and monitoring clusters. You will use K9s to monitor the Bookinfo application and observe metrics, logs, and other relevant information. You will also explore K9s' features for inspecting and troubleshooting microservices.

1. Install K9s:
```
curl -LO https://github.com/derailed/k9s/releases/download/v0.24.2/k9s_Linux_x86_64.tar.gz
tar -xvf k9s_Linux_x86_64.tar.gz
sudo mv k9s /usr/local/bin/
```
{{exec}}

2. Verify the installation:
```
k9s version
```
{{exec}}

3. Launch K9s:
```
k9s
```
{{exec}}

4. Explore the K9s interface:
- Use the arrow keys to navigate through the different resources.
- Press `Enter` to view detailed information about a specific resource.
- Press `Esc` to exit the detailed view and return to the resource list.
- Press `Ctrl+C` to exit K9s.

5. Monitor the Bookinfo application:
- In the K9s interface, navigate to the `pods` resource.
- Select one of the Bookinfo pods.
- Press `Enter` to view detailed information about the selected pod.
- Explore the different tabs to view logs, metrics, and other relevant information.

6. Troubleshoot microservices:
- Use the K9s interface to navigate to the `deployments` resource.
- Select one of the Bookinfo deployments.
- Press `Enter` to view detailed information about the selected deployment.
- Explore the different tabs to view replica sets, pods, and other relevant information.

Congratulations! You have successfully installed K9s and used it to monitor and troubleshoot the Bookinfo application. K9s provides a powerful interface for managing and inspecting Kubernetes resources, making it a valuable tool for DevOps engineers.