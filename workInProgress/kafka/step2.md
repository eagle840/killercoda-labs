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



