# setup


# NOTE


This fixes a docker problem closing down the sonarcube container:   
`sysctl -w vm.max_map_count=262144`{{execute}}



##  Start Sonarcube

`cd ~`{{execute}}

`git clone https://github.com/SonarSource/docker-sonarqube.git`{{execute}}

`cd docker-sonarqube/example-compose-files/sq-with-postgres/`{{execute}}

`docker-compose up -d`{{execute}}

confirm both containers are up:   
`docker-compose ps`{{execute}}

connect to 9000 web page   

{{TRAFFIC_HOST1_9000}}

un and password is admin

# create a new local project

under 'How do you want to create your project?'

select Manually

name and key:  'pyproject'


under 'How do you want to analyze your repository?'

select Locally

and then generate the token, be sure to copy the token.

select language python and OS linux, and copy the code snippet to run latter.

# download and install sonar-qube cli

`cd ~`{{exec}}

`wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.7.0.2747-linux.zip`{{exec}}

`unzip sonar-scanner-cli-4.7.0.2747-linux.zip`{{exec}}

`cd sonar-scanner-cli`{{exec}}

`cd conf`{{exec}}

remove the # in the server name

`nano sonar-scanner.properties`{{exec}}

`cd ..`{{exec}}

`export PATH=$PWD/bin:$PATH`{{exec}}

`echo 'PATH=$PATH':$(pwd)/bin >> /root/.bashrc`{{exec}}

`sonar-scanner -h`{{exec}}