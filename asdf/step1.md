
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

https://asdf-vm.com/


`apt install -y curl git sqlite3`{{exec}}

`apt install -y curl  nodejs npm`{{copy}} # wip don't think I need


`nodejs --version`{{copy}}

`yarn --version`{{copy}}

`sqlite3 --version`{{copy}}

In new tab

`docker-compose up`{{exec}}

### install asdf

`git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.2`{{exec}}

`. "$HOME/.asdf/asdf.sh"`{{exec}}

`. "$HOME/.asdf/completions/asdf.bash"`{{exec}}

`asdf current`{{exec}}

### install ruby



`asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git`{{exec}}

`asdf plugin list all | grep ruby`{{exec}}

`asdf current`{{exec}}

`asdf list all ruby`{{exec}}

`asdf install ruby 2.7.3`{{exec}} # wip: 2.5.0

Now we need to set which version of ruby to use, and the [context](https://asdf-vm.com/guide/getting-started.html#global):

- global: sets for the entire machine from $HOME/.tool-versions
- shell: sets
- local: sets working directory version with $PWD/.tool-versions

`asdf global ruby 2.7.3`{{exec}}


`asdf current`{{exec}}

`ruby -v`{{exec}}

## install nodejs  - WIP takes too long

wip fast install

`apt install -y curl  nodejs npm`{{copy}} # wip don't think I need

`npm install --global yarn`{{exec}}

`nodejs --version`{{copy}}

`yarn --version`{{copy}}

--- asdf node install takes too long

It many uses, you'll need to read the plugin README to understand the install procedure/requirements.
For nodejs see https://github.com/asdf-vm/asdf-nodejs

`asdf install nodejs 18.16.0`{{exec}}

`asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git`{{exec}}

`asdf nodejs nodebuild --version`{{exec}}

`asdf nodejs nodebuild --definitions`{{exec}}

`asdf install nodejs 18.16.0`{{exec}}


`asdf list nodejs`{{exec}}

`asdf current`{{exec}}

`asdf global nodejs 18.16.0`{{exec}}

`asdf current`{{exec}}

`node -v`{{exec}}




=======================================

=== delete below ===
  

`git clone https://github.com/Azure-Samples/ruby-docs-hello-world`{{exec}}

`cd ruby-docs-hello-world`{{exec}}

`git branch -m main`{{exec}}

`ruby -v`{{exec}}

`apt-get -y install libsqlite3-dev   #for bundle install req`{{exec}}

`apt -y install nodejs               # for bundle exec req`{{exec}}

`bundle install`{{exec}}

`bundle exec rails server -b 0.0.0.0`{{exec}}

Link for traffic into host 1 on port 80
{{TRAFFIC_HOST1_3000}}

----WIP---
`gem install rails`{{exec}}

`rails --version`{{exec}}

`rails new blog`{{exec}}

`cd blog`{{exec}}

`bin/rails server -b 0.0.0.0`{{exec}}

or -s

---wip

Bundler:

- package manager that handles gems
- Gems are std ruby libraries
- Bundler comes with Rails
- When bundler starts, gems in gemfile are installed

webpacker:

- frontend
- uses yarn (a js package manager)
- ??? why nodejs needs to be installed?

html at app/views/layouts
- .erb ruby files (erb = embeded ruby)
- a compiler, HAML process the <%=  %>

control: cli
- bin/rails generate controller welcome index




----------- delete below ---------------

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

