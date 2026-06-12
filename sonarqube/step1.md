# setup


# NOTE


This fixes a docker problem closing down the sonarcube container:
`sysctl -w vm.max_map_count=262144`{{execute}}

##  Start Sonarcube

Git repo: https://github.com/SonarSource/docker-sonarqube/blob/master/example-compose-files/README.md



`cd ~`{{execute}}

`git clone https://github.com/SonarSource/docker-sonarqube.git`{{execute}}

`cd docker-sonarqube/example-compose-files/sq-with-postgres/`{{execute}}

`docker-compose up -d`{{exec}}

It will take a few minutes for Sonarcube to startup, so open a new tab, and we'll setup git and sonar-cli




# Git install

some of these might be wrong/duplicate

`cd ~`{{exec}}

# short version

`apt-get update`{{execute}}

`sudo apt update`{{execute}}

`sudo adduser git`{{execute}}


seond set

```
`cd ~`{{exec}}
sudo -u git mkdir /home/git/myproject.git
sudo -u git git init --bare /home/git/myproject.git
sudo chown -R git:git /home/git/myproject.git
git clone git@localhost:/home/git/myproject.git
```{{exec}}

thrid set

```
cd myproject
echo "# My Project" >> README.md
git add README.md
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
git commit -m "Initial commit"
git push origin master
```{{exec}}

# long version



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


# Check  if Sonar cube is up


`curl http://localhost:9000/api/system/health`{{exec}}

confirm both containers are up:
`docker compose ps`{{execute}}

connect to 9000 web page

{{TRAFFIC_HOST1_9000}}

un is `admin`  and    
password is `admin`

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

https://docs.sonarsource.com/sonarqube-server/latest/analyzing-source-code/scanners/sonarscanner/

`cd ~`{{exec}}

## OLD

`wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-7.0.2.4839-linux-x64.zip`{{exec}}

`wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-8.1.0.6389-linux-x64.zip`{{exec}}


`unzip sonar-scanner-cli-8.1.0.6389-linux-x64.zip`{{exec}}

`cd sonar-scanner-cli-8.1.0.6389-linux-x64.zip`{{exec}}

`export PATH="/root/.local/share/sonarqube-cli/bin:$PATH"`{{exec}}

`ls ~/.local/share/sonarqube-cli/bin/ `{{exec}}

`sonar-scanner -h`{{exec}}




## quick start

Sonarqube just release v1, but it gets 'killed'

Docs: https://docs.sonarsource.com/sonarqube-cli

`cd ~`{{exec}}

quick start: `curl -o- https://raw.githubusercontent.com/SonarSource/sonarqube-cli/refs/heads/master/user-scripts/install.sh | bash`{{exec}}

`export PATH="/root/.local/share/sonarqube-cli/bin:$PATH"`{{exec}}

`ls ~/.local/share/sonarqube-cli/bin/ `{{exec}}

`sonar --version`{{exec}}

##  Conf ver 0.8

`cd conf`{{exec}}

WIP: remove the # in the server name

WIP `nano sonar-scanner.properties`{{copy}}

`cd ..`{{exec}}


