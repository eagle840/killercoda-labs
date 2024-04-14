
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

# Run First

`sudo apt update`{{exec}}


following https://learn.microsoft.com/en-us/training/modules/build-web-api-minimal-spa/2-design-front-end

sudo apt update
    4  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.2
    5  . "$HOME/.asdf/asdf.sh"
    6  echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc
    7  . "$HOME/.asdf/completions/asdf.bash"
    8  echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc
    9  asdf current
   10  asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
   11  asdf install nodejs 20.11.1
   12  asdf current
   13  asdf global nodejs 20.11.1
   14  asdf current
   15  node -v
   16  asdf plugin-add yarn
   17  asdf install yarn 1.22.10
   18  asdf global yarn 1.22.10
   19  asdf current
   20  yarn -v
   # this is the quick start > add link to page
   21  npx create-react-app my-app
   22  ls


`git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.2`{{exec}}

`. "$HOME/.asdf/asdf.sh"`{{exec}}


`echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc`{{exec}}

`. "$HOME/.asdf/completions/asdf.bash"`{{exec}}

`echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc`{{exec}}

`asdf current`{{exec}}

`asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git`{{exec}}

`asdf install nodejs 20.11.1`{{exec}}

`asdf current`{{exec}}

`asdf global nodejs 20.11.1`{{exec}}

`asdf current`{{exec}}

`node -v`{{exec}}

`asdf plugin-add yarn`{{exec}}

`asdf install yarn 1.22.10`{{exec}}

`asdf global yarn 1.22.10`{{exec}}

`asdf current`{{exec}}


`yarn -v`{{exec}}

`npx create-react-app my-app`{{exec}}

`ls`{{exec}}


   # this is the MS lab

`npm create vite@latest PizzaClient --template react`{{exec}}

Answer the CLI prompts as follows:

Package name: pizzaclient - The folder created by Vite uses Camel case, PizzaClient.
Select a framework: React
Select a variant: Javascript

`cd PizzaClient/`{{exec}}

`npm install`{{exec}}

   edit vite.config.js

   ```
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,  // Client port
    host: '0.0.0.0' // Bind to all network interfaces
  }
})
   ```
`ls`{{exec}}
 
`npm run dv`{{exec}}

`npm run dev`{{exec}}







-----  delete below

# docker update

`apt-get remove docker  docker.io containerd runc -y`{{exec}}   

`apt-get update`{{exec}}   

`apt-get install ca-certificates curl gnupg  lsb-release -y`{{exec}}   

`mkdir -p /etc/apt/keyrings`{{exec}}   

`curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg`{{exec}}   

```
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```{{exec}}   

`apt-get update`{{exec}}   

`apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y `{{exec}}   

`docker version`{{exec}}   

`docker-compose version`{{exec}}   

`docker compose version`{{exec}}

# Set imageid in index.json

- ubuntu: Ubuntu 20.04 with Docker and Podman
= kubernetes-kubeadm-2nodes: 
- kubernetes-kubeadm-1node:

to taint the control node for work:

```
kubectl taint nodes controlplane node-role.kubernetes.io/master:NoSchedule-
kubectl taint nodes controlplane node-role.kubernetes.io/control-plane:NoSchedule-
```


# Copy Files/adjust index

text here

# Run apt update

apt-get update -y{{execute}}

```apt-get update -y{{execute}}```


# For links to ports:

```
Link for traffic into host 1 on port 80
{{TRAFFIC_HOST1_80}}
Link for traffic into host 2 on port 4444
{{TRAFFIC_HOST2_4444}}
Link for traffic into host X on port Y
{{TRAFFIC_HOSTX_Y}}
```


# Example setup for postgres with raw data

git clone https://github.com/josephmachado/simple_dbt_project.git

- raw folders
- warehouse setup
- docker postgres and -v to those folders


We'll be using the rabbitmq container with the management feature installed.

https://hub.docker.com/_/rabbitmq

`docker run -d --hostname my-rabbit --name some-rabbit -p 8080:15672 rabbitmq:3-management`{{execute}}

make sure it started

`docker ps`{{execute}}

and check the config file

`docker exec some-rabbit cat /etc/rabbitmq/rabbitmq.conf`{{execute}}

and head over to port 8080 and login   
un:guest   
pw:guest  


Next we'll update the python files with the new IP address of the docker container.

`RabbitIP=$(docker inspect some-rabbit | jq -r .[0].NetworkSettings.IPAddress)`{{execute}}

`echo $RabbitIP`{{execute}}

`sed -i "s/localhost/$RabbitIP/g" send.py receive.py worker.py new_task.py`{{execute}}

## k8s port-forward

`k -n <ns> port-forward service/<svc-name> 9090:9090 --address 0.0.0.0`

- this is to forword a CLusterIP so that killacoda can access


`echo 'PATH=$PATH':$(pwd)/bin >> /root/.bashrc`{{copy}}

export PATH=$PWD/bin:$PATH

to allow pods on the controlplane

`kubectl taint node controlplane node-role.kubernetes.io/master:NoSchedule-`{{copy}}

to allow access to running pods with ports 9000 and 9090

`kubectl port-forward -n minio-dev pod/minio 9000 9090 --address 0.0.0.0`{{copy}}

