# Install trivy

Update the apt package manager

`apt update`{{execute}}

Install the requirements

`sudo apt-get -y install wget apt-transport-https gnupg lsb-release`{{execute}}

`wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo  apt-key add -`{{execute}}

`echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list`{{execute}}

`sudo apt-get update`{{execute}}

Install Trivy

`sudo apt-get -y install trivy`{{execute}}

`trivy -h`{{execute}}
   