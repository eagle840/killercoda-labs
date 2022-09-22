# Adding extra agents

be sure you changed the execstart on step 1

## Add the Docker Plugin

in jenkins, select 'Manage Jenkins' > 'Manage Plugins'

click on the available tab and enter 'docker' in the search field and select just 'Docker', the one tagged with 'cloud provider'.

click 'Download now and install after reboot', check the box 'Restart jenkins...' when shown and jenkins will restart

killercoda will prompt you to connect to the port again (8080) - wait 30 seconds - click 'display port' and login.

## Config Jenkins to startup Docker Agents

First thinks the docker default <gateway address>:

List the docker networks   
`docker network ls`{{execute}}   
look for root_default  bridge  
`docker inspect network root_default`{{exec}}  
in that output, look for the gateway address (eg 172.19.0.1)

Now we need to do a small change to allow Jenkins to work with killacoder:

goto 'manage jenkins' > 'Configure Global Security' and under 'CSRF Protection' enable the proxy.

Now lets configure jenkins with docker:

goto 'manage jenkins' > 'manage nodes and clouds'

click on 'configure clouds' on LHS

on the drop-down select 'docker' and the page will refresh with more content

Select 'Docker Cloud Details'

in the Docker Host URI, enter: 'tcp://<gateway address>:2375'

and click 'test connection' and you should get back the API version

check 'Enabled'   
check 'Expose DOCKER_HOST'

now click on 'Docker Agent Templates..' => 'Add Docker Template'

Give it the label  'Agent', and check 'Enabled', and Name it 'Jenkins Agent' and enter the docker image (the same as the one we used in step 1) 'jenkins/jenkins:2.370'

Set the instance capacity to '10'

set the Remote File system root  (check this works) `/var/jenkins_home`{{copy}}

finally check save


