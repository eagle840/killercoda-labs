
# Initial Setup

## Install Ruby-on-Rails

`sudo apt update`{{exec}}

`sudo apt install y  postgresql postgresql-contrib sqlite3`{{exec}}

`sudo systemctl start postgresql.service`{{exec}}

`sudo apt install ruby-full`{{exec}}

see the asdf lab for details on custom installs of ruby.


To install Ruby on Rails on Ubuntu, you can follow these steps:

Step 1: Update system packages

`sudo apt update`{{exec}}

Step 2: Install Ruby using rbenv

WIP rbenv install 2.7.2 takes too long

```
sudo apt install -y git curl libssl-dev libreadline-dev zlib1g-dev
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
rbenv install 2.7.2
rbenv global 2.7.2
```{{exec}}

Step 3: Install Rails
```
gem install rails
```{{exec}}

Step 4: Verify installation
```
ruby -v
rails -v
```{{exec}}

Now that you have Rails installed, let's create a demo app:

Step 5: Create a new Rails application
```
rails new demo_app
cd demo_app
```{{exec}}

Step 6: Start the Rails server
```
rails server -b 0.0.0.0
```{{exec}}

Now you can access the demo app by opening a web browser and visiting `http://localhost:3000`.

On killacode: {{TRAFFIC_HOST1_3000}}

### To remove the warning
add __config.hosts.clear__ to the  `config/environments/development.rb` file`, in the 'do' section

This will create a basic Rails application with the necessary files and directories. You can explore the generated code and start building your lab exercises based on the sections mentioned earlier.


## Hello world

Let add 'Hello world'

https://guides.rubyonrails.org/getting_started.html#say-hello-rails





===========  Delete Below  ===================================
Doc: https://killercoda.com/creators

github: https://github.com/killercoda

# Run First

`sudo apt update`{{exec}}

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

