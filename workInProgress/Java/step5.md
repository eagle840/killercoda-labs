# Web based monitoring


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
