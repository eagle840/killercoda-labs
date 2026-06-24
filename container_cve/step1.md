# Step 1: Install Trivy & Run a Basic Scan

First, we will install Trivy on our Ubuntu server and run a basic container image scan to see how base image versions affect the number of vulnerabilities.

### 1. Update the Package List
Update the local package index to ensure we fetch the latest system tools:
`apt-get update`{{execute}}

### 2. Install Prerequisites
Install the required HTTPS and certificate utilities to safely fetch Trivy's repository keys:
`sudo apt-get -y install wget apt-transport-https gnupg lsb-release`{{execute}}

### 3. Add the Trivy GPG Key and APT Repository
Download the GPG key and add the Trivy repository to your system sources:
`wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null`{{execute}}

`echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/trivy.list`{{execute}}

`sudo apt-get update`{{execute}}

### 4. Install Trivy
Install the Trivy package:
`sudo apt-get -y install trivy`{{execute}}

Verify that Trivy is successfully installed:
`trivy --version`{{execute}}

### 5. Run a Basic Image Scan (The "Easy Win")
Let's see why updating base images is critical. Run a scan against the old `alpine:3.11` base image and count the total vulnerabilities:
`trivy image alpine:3.11`{{execute}}

Now, scan the current `alpine:latest` base image and compare the difference:
`trivy image alpine:latest`{{execute}}

You will notice that `alpine:latest` has zero (or very few) vulnerabilities, demonstrating how a simple base image update can instantly improve security!