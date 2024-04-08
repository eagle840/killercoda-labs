
CREATE A TOPIC TO STORE YOUR EVENTS

https://kafka.apache.org/quickstart#quickstart_createtopic


`bin/kafka-topics.sh --create --topic quickstart-events --bootstrap-server localhost:9092`{{exec}}

`bin/kafka-topics.sh --describe --topic quickstart-events --bootstrap-server localhost:9092`{{exec}}

WRITE SOME EVENTS INTO THE TOPIC

`bin/kafka-console-producer.sh --topic quickstart-events --bootstrap-server localhost:9092`{{exec}}

send:

`This is my first event`{{exec}}

`This is my second event`{{exec}}

READ THE EVENTS

`bin/kafka-console-consumer.sh --topic quickstart-events --from-beginning --bootstrap-server localhost:9092`{{exec}}


## keep following quickstart https://kafka.apache.org/quickstart#quickstart_kafkaconnect

--- 

# start grafana on a docker container

https://grafana.com/docs/grafana/latest/setup-grafana/installation/docker/



--- delete below ---

# Setup java program

### generate zip

we'll be using : https://spring.io/quickstart

WIP (or use  https://github.com/spring-projects/spring-petclinic)

start.spring.io

- project: maven
- language: java
- sprintboot: 2.3.x
- description: sample api
- packaging: jar
- Java: 8


dependiences
- spring web

Download - we'll upload it shortly

### upload

open the editor tab, and upload the zip file

extract:

`unzip`

### edit 

in 'src/main/java/com/example/demo'

edit the file 'DemoApplication.java'

```java

              package com.example.demo;
              import org.springframework.boot.SpringApplication;
              import org.springframework.boot.autoconfigure.SpringBootApplication;
              import org.springframework.web.bind.annotation.GetMapping;
              import org.springframework.web.bind.annotation.RequestParam;
              import org.springframework.web.bind.annotation.RestController;
              
              @SpringBootApplication
              @RestController
              public class DemoApplication {
                
                  
                  public static void main(String[] args) {
                  SpringApplication.run(DemoApplication.class, args);
                  }
                  
                  @GetMapping("/hello")
                  public String hello(@RequestParam(value = "name", defaultValue = "World") String name) {
                  return String.format("Hello %s!", name);
                  }
                
              }
```            


run with maven:

`./mvnw spring-boot:run`{{copy}}



