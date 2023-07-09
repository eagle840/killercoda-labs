
# Initial Setup

Make docs: https://www.gnu.org/software/make/manual/make.html

Make Repo: https://savannah.gnu.org/projects/make/

`make -v`{{exec}}

`make -h`{{exec}}

[taken from gnu.org](https://www.gnu.org/software/make/manual/make.html#Rule-Introduction)

A simple makefile consists of “rules” with the following shape:

! indents MUST be tabs, or you will get an error 'Makefile:<ln#>: *** missing separator.  Stop'

```
target … : prerequisites …
        recipe
        …
        …
```

When used in Devops:

A ***target*** is usually the name of a filename or an action to carry out, such as ‘clean’ [see Phony Targets(https://www.gnu.org/software/make/manual/make.html#Phony-Targets).

A ***prerequisite*** is a file or action that is used as input to create the target. A target often depends on several files. (sometimes call dependiences)

A ***recipe*** is an action that make carries out. A recipe may have more than one command, either on the same line or each on its own line. **Please note**: you need to put a tab character at the beginning of every recipe line! This is an obscurity that catches the unwary. If you prefer to prefix your recipes with a character other than tab, you can set the .RECIPEPREFIX variable to an alternate character (see Other Special Variables).

Usually a recipe is in a rule with prerequisites and serves to create a target file if any of the prerequisites change. However, the rule that specifies a recipe for the target need not have prerequisites. For example, the rule containing the delete command associated with the target ‘clean’ does not have prerequisites.

A rule, then, explains how and when to remake certain files which are the targets of the particular rule. make carries out the recipe on the prerequisites to create or update the target. A rule can also explain how and when to carry out an action. See Writing Rules.

A makefile may contain other text besides rules, but a simple makefile need only contain rules. Rules may look somewhat more complicated than shown in this template, but all fit the pattern more or less.

## First Makefile

`nano Makefile`{{exec}}

```
# Define the target file
output: input.txt
	@echo "Building output file..."
	@cp input.txt output
	@echo "Output file built."

# Define a rule to check if the input file exists
input.txt:
	@echo "Checking if input file exists..."
	@if [ ! -f input.txt ]; then \
    	echo "Input file not found. Creating a new one..."; \
    	echo "This is the input file." > input.txt; \
	fi
  ```


In this example, we have a target file named `output` that depends on `input.txt`. The `output` file is built by copying the contents of `input.txt`.

The `input.txt` rule checks if the file exists using the `-f` flag with the `[` command. If the file doesn't exist, it creates a new one with some sample content.

When you run `make output`, it first checks if `input.txt` exists. If it doesn't, it creates a new one. Then, it compares the modification time of `input.txt` and `output`. If `input.txt` is newer or `output` doesn't exist, the commands under the `output` rule are executed to build the target file.


Notes: prerequisites/dependencies

In the context of makefiles, "prerequisites" and "dependencies" are often used interchangeably to refer to the files that a target depends on. However, there is a slight difference in their usage.

"Prerequisites" typically refers to the files that are directly specified in the makefile rule as dependencies of a target. These are explicitly declared and listed after the target in the rule.

"Dependencies" can have a broader meaning and can include both the directly specified prerequisites and any other files that those prerequisites depend on. In other words, dependencies can include both direct and indirect dependencies of a target.


==============================

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

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

