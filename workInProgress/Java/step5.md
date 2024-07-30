# Web based monitoring

## JMX

JMX stands for Java Management Extensions. It is a technology that allows monitoring and managing Java applications, system objects, and devices. JMX provides a standard way to expose management and monitoring information about Java applications, making it easier to monitor and manage Java applications in a consistent manner.

With JMX, developers can instrument their Java applications by exposing managed beans (MBeans) that provide information about the application's internal state, configuration, and performance metrics. These MBeans can be accessed and manipulated using JMX-compliant tools and libraries.

Some common use cases for JMX include:

1. Monitoring application performance metrics such as memory usage, CPU usage, and thread count.
2. Configuring application settings at runtime without restarting the application.
3. Triggering actions or notifications based on certain conditions or thresholds.
4. Integrating with monitoring tools and frameworks like JConsole, VisualVM, or Nagios.

Overall, JMX is a powerful tool for managing and monitoring Java applications, providing developers and administrators with valuable insights into the runtime behavior of their applications.

https://jolokia.org/index.html

## javamelody



https://github.com/javamelody/javamelody/wiki





## hawtio



https://hawt.io/docs/get-started/



`wget https://repo1.maven.org/maven2/io/hawt/hawtio-app/3.0-M6/hawtio-app-3.0-M6.jar`{{exec}}


`java -jar hawtio-app-3.0-M6.jar`{{copy}} we need it to listen on 0.0.0.0


`java -jar hawtio-app-3.0-M6.jar -hst 0.0.0.0`{{exec}}

add to utl /hawtio/connect

{{TRAFFIC_HOST1_8080}}/hawtio/connect

## Intro to JMX

 Java JMX (Java Management Extensions) is a technology that allows monitoring and managing Java applications, as well as the Java Virtual Machine (JVM) itself, in a distributed environment. It provides a standard way to expose and manage the resources and operations of a Java application through a set of APIs.

With JMX, you can monitor various aspects of your Java application, such as memory usage, CPU utilization, thread count, and garbage collection statistics. It also allows you to manage and control the application by invoking methods remotely, changing configuration parameters, and receiving notifications about specific events.

JMX is widely used in enterprise applications to monitor and manage Java-based systems, especially in production environments. It provides a flexible and extensible framework for building monitoring and management tools, and it is supported by many application servers and monitoring tools.


--

#Jmeter

https://stackoverflow.com/questions/67419731/use-jmeter-desktop-application-as-web-app#:~:text=Currently%20running%20JMeter%20as%20a,someone%20else)%20will%20be%20able

`nano Dockerfile`{{exec}}

WIP apk update

https://wiki.alpinelinux.org/wiki/Alpine_Package_Keeper  WIP add to docker tutorial

```
FROM uphy/novnc-alpine
RUN \
    apk add --no-cache curl openjdk8-jre bash \
    && curl -L https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.4.1.tgz >  /tmp/jmeter.tgz \
    && mkdir -p /opt \
    && tar -xvf /tmp/jmeter.tgz -C /opt \
    && rm /tmp/jmeter.tgz \
    && cd /etc/supervisor/conf.d \
    && echo '[program:jmeter]' >> supervisord.conf \
    && echo 'command=/opt/apache-jmeter-5.4.1/bin/./jmeter' >> supervisord.conf \
    && echo 'autorestart=true' >> supervisord.conf
```
`docker build -t jmeter .`{{exec}}

`docker run -it --rm -p 8080:8080 jmeter`{{exec}}

http://localhost:8080/vnc.html

---


need a base that has x11 loaded


in container:
```
   1  cp /html/* .
    2  http-server
    3  http-server -h
    4  http-server
    5  curl
    6  apk update
    7  apt update
    8  apt install curl
    9  apt install openjdk8-jre
   10  apt install java
   11  apt-get install default-jdk
   12  java -version
   13  curl -L https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.4.1.tgz >  /tmp/jmeter.tgz
   14  mkdir -p /opt
   15  tar -xvf /tmp/jmeter.tgz -C /opt
   16  rm /tmp/jmeter.tgz
   17  cd /etc/supervisor/conf.d
   18  /opt/apache-jmeter-5.4.1/bin/./jmeter
   19  history
   ```
