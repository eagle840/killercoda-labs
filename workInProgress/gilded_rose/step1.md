
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

# Run First

`sudo apt update`{{exec}}

`git clone https://github.com/emilybache/GildedRose-Refactoring-Kata`{{exec}}

Here are some key differences between **xUnit** and **NUnit**:

- **Instance Management**: **NUnit** runs all tests using the same class instance, while **xUnit** creates a new instance for each test³.
- **Setup and Teardown**: **NUnit** uses `[SetUp]` and `[TearDown]` attributes for setup and teardown logic, whereas **xUnit** uses a parameterless constructor and the `IDisposable` interface³.
- **Attributes**: **xUnit** uses the `[Fact]` attribute instead of `[Test]` used by **NUnit**¹.
- **Extensibility**: **xUnit** is considered more extensible compared to **NUnit**¹.

Which framework are you considering for your project?

Source: Conversation with Copilot, 11/11/2024
(1) Comparing xUnit and NUnit for Unit Testing - XCentium. https://blogs.xcentium.com/blogs/comparing-xunit-and-nunit-for-unit-testing.
(2) NUnit vs. XUnit vs. MSTest: Unit Testing Frameworks. https://www.lambdatest.com/blog/nunit-vs-xunit-vs-mstest/.
(3) xUnit vs. NUnit Demystified: A Comprehensive Explanation - Testim. https://www.testim.io/blog/xunit-vs-nunit/.

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
