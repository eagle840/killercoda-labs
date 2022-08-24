# Docker-compose

Lets setup Kafka on docker compose, open a new window

`mkdir kdc`{{exec}}
`cd kdc`{{exec}}
`nano docker-compose.yml`{{exec}}#

THIS: https://github.com/provectus/kafka-ui

appears to have method for sends msgs

```sh
---
version: "2"
services:
  kafdrop:
    image: obsidiandynamics/kafdrop
    restart: "no"
    ports:
      - "9000:9000"
    environment:
      KAFKA_BROKERCONNECT: "kafka:29092"
      JVM_OPTS: "-Xms16M -Xmx48M -Xss180K -XX:-TieredCompilation -XX:+UseStringDeduplication -noverify"
    depends_on:
      - "kafka"
  kafka:
    image: obsidiandynamics/kafka
    restart: "no"
    ports:
      - "2181:2181"
      - "9092:9092"
    environment:
      KAFKA_LISTENERS: "INTERNAL://:29092,EXTERNAL://:9092"
      KAFKA_ADVERTISED_LISTENERS: "INTERNAL://kafka:29092,EXTERNAL://localhost:9092"
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: "INTERNAL:PLAINTEXT,EXTERNAL:PLAINTEXT"
      KAFKA_INTER_BROKER_LISTENER_NAME: "INTERNAL"
      KAFKA_ZOOKEEPER_SESSION_TIMEOUT: "6000"
      KAFKA_RESTART_ATTEMPTS: "10"
      KAFKA_RESTART_DELAY: "5"
      ZOOKEEPER_AUTOPURGE_PURGE_INTERVAL: "0"



```{{copy}}
taken from: https://github.com/obsidiandynamics/kafdrop/tree/master/docker-compose/kafka-kafdrop


lets check the yaml for errors:

`docker-compose config`{{exec}}

Startup the kafka-server

`docker-compose up`{{exec}}

To monitor the kafka server with Kafdrop UI, open:

{{TRAFFIC_HOST1_9000}}

# Monitoring

An excellent blog article on monitoring Kafka:
https://towardsdatascience.com/overview-of-ui-tools-for-monitoring-and-management-of-apache-kafka-clusters-8c383f897e80

https://github.com/obsidiandynamics/kafdrop