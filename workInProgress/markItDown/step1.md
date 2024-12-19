
# Mark it down


# lab layout

1) basic use. git clone, and test it on a doc

2) architect it
    - api endpoint with either
        - location of file (upload into storeage, soo need azurite, and local document db (azurti, or opensource)
        - binary of file
    - process file
    - return file
        - as binary
        - or locatopn

## install tools

`apt update`{{exec}}

`apt install -y jq python3-pip `{{exec}}


`git clone https://github.com/microsoft/markitdown.git

`pip install markitdown

or from source:

`pip install -e .

we'll be using the comd markitdown `path-to-file.pdf > document.md` or `cat path-to-file.pdf | markitdown `


## basic

```
from markitdown import MarkItDown

md = MarkItDown()
result = md.convert("test.xlsx")
print(result.text_content)
```

## llms

```
from markitdown import MarkItDown
from openai import OpenAI

client = OpenAI()
md = MarkItDown(llm_client=client, llm_model="gpt-4o")
result = md.convert("example.jpg")
print(result.text_content)
```

## docker

```
docker build -t markitdown:latest .
docker run --rm -i markitdown:latest < ~/your-file.pdf > output.md
```{{exec}}


# Remove below?

## run Rabbitmq


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

[access web gui]({{TRAFFIC_HOST1_8080}})


## Update python files with correct config

Next we'll update the python files with the new IP address of the docker container.

`RabbitIP=$(docker inspect some-rabbit | jq -r .[0].NetworkSettings.IPAddress)`{{execute}}

`echo $RabbitIP`{{execute}}

`sed -i "s/localhost/$RabbitIP/g" send.py receive.py worker.py new_task.py`{{execute}}
