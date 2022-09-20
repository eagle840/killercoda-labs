# Using the Jenkins CLI

Goto manage Jenkins, and in the 'tools & actions' section select Jenkins cli. 

copy the java command shown, we will need to alter it.

There will be a link to the java file that will look like:

`https://9216591e-959c-4fd7-8b09-70339eda1ed0-10-244-15-229-8080.spch.r.killercoda.com/jnlpJars/jenkins-cli.jar`

Download this using wget: (example)

`wget https://9216591e-959c-4fd7-8b09-70339eda1ed0-10-244-15-229-8080.spch.r.killercoda.com/jnlpJars/jenkins-cli.jar`

We will need java to run this (Jenkins/Java is running it's own container)

`apt install openjdk-8-jdk`{{exec}}

But first we need api authN token.

In the top right, click on your name, and then 'configure`

create and copy a new API token

Now in the java cmd for the cli, we will need to add the -auth <name>:<token> option: (example)

`java -jar jenkins-cli.jar -s https://9216591e-959c-4fd7-8b09-70339eda1ed0-10-244-15-229-8080.spch.r.killercoda.com/ -auth admin:1173e1394e41537d1d3453379cabd5ef13 -webSocket help`

Note the the last item in the command is 'help' - all the available commands that you can run. 

try running the command 'list-kobs'


### install plugin

run the list-plugins (example):

`java -jar jenkins-cli.jar -s https://9216591e-959c-4fd7-8b09-70339eda1ed0-10-244-15-229-8080.spch.r.killercoda.com/ -auth admin:1173e1394e41537d1d3453379cabd5ef13 -webSocket list-plugins`


use .hpi files

https://updates.jenkins-ci.org/download/plugins/

goto https://plugins.jenkins.io/

search for your plugin

when found, click on the 'releases' tab: you'll find various links to the url for the download.

copy the 'Download: direct link'  link, and use it for the url:

'install-plugin <url>'

example:

`java -jar jenkins-cli.jar -s https://9216591e-959c-4fd7-8b09-70339eda1ed0-10-244-15-229-8080.spch.r.killercoda.com/ -auth admin:1173e1394e41537d1d3453379cabd5ef13 -webSocket install-plugin  https://updates.jenkins-ci.org/download/plugins/bitbucket/1.1.30/bitbucket.hpi`

Sometimes, if you can't disable the plugin in the web gui, you can try the cli


