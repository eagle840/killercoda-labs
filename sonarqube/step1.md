# setup


# NOTE


This fixes a docker problem closing down the sonarcube container:
`sysctl -w vm.max_map_count=262144`{{execute}}


## Docker remove

`docker version`{{exec}}

`docker-compose version`{{exec}}

`docker compose version`{{exec}}

`apt-get remove docker  docker.io containerd runc -y`{{exec}}

## Docker install

`apt-get install ca-certificates curl gnupg  lsb-release -y`{{exec}}

`mkdir -p /etc/apt/keyrings`{{exec}}

`curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg`{{exec}}

```
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```{{exec}}

`apt-get update`{{exec}}

`apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y`{{exec}}

## Docker version check

`docker version`{{exec}}

`docker-compose version`{{exec}}

`docker compose version`{{exec}}


# Git install

some of these might be wrong/duplicate


`apt-get update`{{execute}}

`sudo apt update`{{execute}}

`sudo apt install -y git`{{execute}}

`sudo adduser git`{{execute}}

`sudo -u git mkdir /home/git/myproject.git`{{execute}}

`sudo -u git git init --bare /home/git/myproject.git`{{execute}}

`sudo chown -R git:git /home/git/myproject.git`{{execute}}

`git clone git@localhost:/home/git/myproject.git`{{execute}}

`cd myproject`{{execute}}

`echo "# My Project" >> README.md`{{execute}}

`git add README.md`{{execute}}

`git config --global user.email "you@example.com"`{{execute}}

`git config --global user.name "Your Name"`{{execute}}

`git commit -m "Initial commit"`{{execute}}

`git push origin master`{{execute}}



##  Start Sonarcube

`cd ~`{{execute}}

`git clone https://github.com/SonarSource/docker-sonarqube.git`{{execute}}

`cd docker-sonarqube/example-compose-files/sq-with-postgres/`{{execute}}

WIP `docker-compose up -d`{{copy}}

`docker compose up -d`{{execute}}

It will take a few minutes for Sonarcube to startup

confirm both containers are up:
`docker compose ps`{{execute}}

connect to 9000 web page

{{TRAFFIC_HOST1_9000}}

un and password is `admin`

Update the new password when prompted `Admin123456789!`{{copy}}

# create a new local Sonarqube project

under 'How do you want to create your project?'

select Manually

name and key:  'pyproject'


under 'How do you want to analyze your repository?'

select Locally

and then generate the token, be sure to copy the token.

select language python and OS linux, and copy the code snippet to run latter.

# download and install sonar-qube cli

When your on the sonarcube server, setting up a project - you'll see the instructions for setting up the scanner, we have done this for you below:



`cd ~`{{exec}}

`wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.7.0.2747-linux.zip`{{copy}}

`wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.7.0.2747-linux.zip`{{copy}}

`wget https://github.com/SonarSource/sonar-scanner-cli/archive/refs/tags/7.0.2.4839.zip`{{exec}}

`unzip sonar-scanner-cli-4.7.0.2747-linux.zip`{{exec}}

`cd sonar-scanner-4.7.0.2747-linux/`{{exec}}

`cd conf`{{exec}}

remove the # in the server name

`nano sonar-scanner.properties`{{exec}}

`cd ..`{{exec}}

`export PATH=$PWD/bin:$PATH`{{exec}}

`echo 'PATH=$PATH':$(pwd)/bin >> /root/.bashrc`{{exec}}

`sonar-scanner -h`{{exec}}
