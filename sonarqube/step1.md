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



## OLD

`cd ~`{{exec}}

`wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-8.1.0.6389-linux-x64.zip`{{exec}}


`unzip sonar-scanner-cli-8.1.0.6389-linux-x64.zip`{{exec}}

`cd sonar-scanner-8.1.0.6389-linux-x64/`{{exec}}

`export PATH="/root/sonar-scanner-8.1.0.6389-linux-x64/bin:$PATH"`{{exec}}

`sonar-scanner -h`{{exec}}


Docs: https://docs.sonarsource.com/sonarqube-cli


##  Conf ver 0.8

`cd conf`{{exec}}

WIP: remove the # in the server name

WIP `nano sonar-scanner.properties`{{exec}}

and set to:

`sonar.host.url=http://localhost:9000`{{exec}}

`cd ..`{{exec}}


