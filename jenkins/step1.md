# Setup Jenkins

Do an apt update, and install some tools

`apt update`{{exec}}

`apt install -y jq tree`{{exec}}

Let's first setup a folder to store our Jenkins data:   

`mkdir jenkins`{{execute}}

`chmod 777 jenkins`{{execute}}

and pull the Jenkin's Image:   

`docker pull jenkins/jenkins:2.332`{{execute}}     

It this lab we're using a set image version of Jenkins, you might want to try jenkins:lts

We'll also use mailhog as a mail server@
   
`docker pull mailhog/mailhog`{{execute}}   

`nano docker-compose.yml`{{execute}}

```yaml
version: "3.3"

services:

  jenkins:
    image: jenkins/jenkins:2.332
    ports:
    - "8080:8080"
    - "50000:50000"
    volumes:
    - ./jenkins:/var/jenkins_home
    restart: unless-stopped

  mails:
    image: mailhog/mailhog
    restart: unless-stopped
    ports:
    - "8025:8025"
    - "1025:1025"
```{{copy}}

### start the jenkins docker container



`docker-compose up`{{execute}}

after a minute or two, jenkins should come up, you'll see the password in stdout

Or run in Terminal 2

`docker exec root_jenkins_1 cat /var/jenkins_home/secrets/initialAdminPassword`{{execute}}


### Open pages  for  mailhog on 8025  and jenkins on 8080 

Jenkins:

{{TRAFFIC_HOST1_8080}}

Mailhog:

{{TRAFFIC_HOST1_8025}}

Complete the Jenkins install until you're at the main page before continuing. Use UN: admin  PW: Admin4321 email: admin@example.com

### Configure access to port 2375 on the docker daemon.

Once you've complete the Jenkins setup we need to configure access to dockers api

lets check the status of the docker service

`sudo systemctl status docker.service`{{execute}}

lets open up port 2375 so we can allow jenkins to interact with the docker daemon data

`sudo nano /lib/systemd/system/docker.service`{{execute}}   

find the line starting with  ExecStart in the [service] section and add `-H tcp://0.0.0.0` just after  fd://

and restart the docker daemon

`sudo systemctl daemon-reload`{{execute}}

`sudo systemctl restart docker.service`{{execute}}

recheck the docker service is running:

`sudo systemctl status docker.service`{{execute}}

and make sure we're getting the json data


`curl localhost:2375/containers/json | jq`{{execute}}

### setup jenkins to send mail to mailhog

Goto Manage Jenkins, then 'Configure System'. Scroll down to the bottom of the page.

set the email server to 'mails' (the service in docker-compose)   

expand out the advanced section and set the port to 1025, 

then check the 'test configuration...', enter an email address, and click 'Test'.

You should see that email show in the mailhog portal.



