# Initial Setup

`apt update`{{exec}}

`apt install -y net-tools jq tree`{{exec}}

Since Kafka uses Java:

`apt install default-jre`{{exec}}

`java -version`{{exec}}


# Install kafka

Let's use kafka's quick start
https://kafka.apache.org/quickstart

download kafka at
https://www.apache.org/dyn/closer.cgi?path=/kafka/2.4.0/kafka_2.12-2.4.0.tgz


`wget https://archive.apache.org/dist/kafka/2.4.0/kafka_2.11-2.4.0.tgz`{{execute}}

extract the file and cd into the folder

`tar -xzf kafka_2.11-2.4.0.tgz`{{execute}}

`cd kafka_2.11-2.4.0/`{{execute}}

## Start the server and create a topic

start zookeeper, then kafka

`bin/zookeeper-server-start.sh config/zookeeper.properties &`{{execute}}

Now open a new terminal window

`bin/kafka-server-start.sh config/server.properties &`{{execute}}

Add another terminal window

Create a topic

`bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic test`{{execute}}

confirm the topic is created:{{execute}}
`bin/kafka-topics.sh --list --bootstrap-server localhost:9092`{{execute}}

