
# Initial Setup

First we'll setup the environment

`apt-get update -y{{execute}}`

```apt-get update -y{{execute}}```

`apt install net-tools tree jq  python3-pip -y`{{exec}}

`git clone https://github.com/mlflow/mlflow`{{exec}}

`cd mlflow/examples/quickstart/`{{exec}}

`pip install mlflow`{{exec}}

Since we're running it on killercoda, will specify a host of 0.0.0.0 so it can be accessed by any computer.

`mlflow ui --host 0.0.0.0`{{exec}}

you can access the ui at port 5000 {{TRAFFIC_HOST1_5000}}



##################  scrap

might be better of using https://mlflow.org/docs/latest/tutorials-and-examples/index.html

some of the mlprojects appear to need conda, so use a docker image?

docker run -i -t continuumio/anaconda3 /bin/bash


`docker run -it -p 5000:5000 continuumio/anaconda3 /bin/bash`

from: https://hub.docker.com/r/continuumio/anaconda3  (with instructions)

    1  pip install mlflow
    2  git clone https://github.com/mlflow/mlflow
    3   # cd mlflow/examples/quickstart/
    4  mlflow run sklearn_elasticnet_wine -P alpha=0.5  # <= appears to need to be in ~ dir


    ==================================


    1  pip install mlflow[extras]
    2  git clone https://github.com/mlflow/mlflow
    3  cd mlflow/examples/
    4  cat sklearn_elasticnet_wine/train.py

   12  ls -lash  sklearn_elasticnet_wine/
   13  python sklearn_elasticnet_wine/train.py

   
   17  ls -lash  mlruns/

   20  ls -lash  ./mlruns/0  # note the directory with the numbers
       # run again with different values
   21  python sklearn_elasticnet_wine/train.py 0.3 0.6
       # new mlruns folder created
   24  ls -lash  ./mlruns/0

   now run mlflow ui --host 0.0.0.0  # 0.0.0.0 is needs or you'll get an 502 gateway error

   you'll now see the 'flows' in the web page

   Looking at the mlflows folder

   each <number> folder is an 'experiment' as shown in the UI.
     - meta data file: basic info about the experiment, inc 'name'
     - tags folder - more info about the 'experiment'
     - numbered folders for each run of the ml program


# For links to ports:

```
Link for traffic into host 1 on port 80
{{TRAFFIC_HOST1_80}}
Link for traffic into host 2 on port 4444
{{TRAFFIC_HOST2_4444}}
Link for traffic into host X on port Y
{{TRAFFIC_HOSTX_Y}}
```


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

https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com

Next we'll update the python files with the new IP address of the docker container.

`RabbitIP=$(docker inspect some-rabbit | jq -r .[0].NetworkSettings.IPAddress)`{{execute}}

`echo $RabbitIP`{{execute}}

`sed -i "s/localhost/$RabbitIP/g" send.py receive.py worker.py new_task.py`{{execute}}

