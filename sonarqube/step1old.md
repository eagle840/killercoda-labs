# setup


# NOTE

Memory limits on this platform are not allowing the containers to run. This lab is being moved over to another platform.

## Git server#
#
follow https://hub.docker.com/r/jkarlos/git-server-docker/

You'll have to do a 

`ssh-keygen -t rsa`{{execute}}

note that we are using the /git-serve folder as  a container volume

`docker run -d -p 2222:22 --name gitserve -v ~/git-server/keys:/git-server/keys -v ~/git-server/repos:/git-server/repos jkarlos/git-server-docker`{{execute}}

copy our keys over to the container

`cp ~/.ssh/id_rsa.pub ~/git-server/keys`{{execute}}

`docker restart gitserve`{{execute}}


--- this point it testing

`mkdir myrepo`{{execute}}

`cd myrepo`{{execute}}

`git init --shared=true`{{execute}}

`touch text.txt`{{execute}}


`git add .`{{execute}}

`git config --global user.email "you@example.com"`{{execute}}

`git config --global user.name "Your Name"`{{execute}}

`git commit -m "my first commit"`{{execute}}


`cd ..`{{execute}}

`git clone --bare myrepo myrepo.git`{{execute}}

move the repo over to the container

`mv myrepo.git ~/git-server/repos`{{execute}}

Lets create a new directory and clone the repo!

`cd ~`{{execute}}

`mkdir test`{{execute}}

`cd test`{{execute}}

`git clone ssh://git@localhost:2222/git-server/repos/myrepo.git`{{execute}}

`ls`{{execute}}

### create a new repo using ssh(thats above right?) or git cmd

...content



## Sonarcube

`cd ~`{{execute}}

`git clone https://github.com/SonarSource/docker-sonarqube.git`{{execute}}

`cd docker-sonarqube/example-compose-files/sq-with-postgres/`{{execute}}

comfirm docker can pull

This fixes a docker problem closing down the sonarcube container:   
`sysctl -w vm.max_map_count=262144`{{execute}}


`docker-compose up -d`{{execute}}

confirm both containers are up:   
`docker-compose ps`{{execute}}

connect to 9000 web page   
https://[[HOST_SUBDOMAIN]]-9000-[[KATACODA_HOST]].environments.katacoda.com

un and password is admin

## GIT server

`docker stats`{{execute}}

 check memory usage!