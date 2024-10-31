# ChatGPt





# Stackoverflow

https://stackoverflow.com/questions/67419731/use-jmeter-desktop-application-as-web-app

`touch Dockerfile`{{exec}}


```
FROM uphy/novnc-alpine
RUN \
    apk update \
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

WIP Got error

- looks like you need to update the apk signature

```
Step 2/2 : RUN     apk add --no-cache curl openjdk8-jre bash     && curl -L https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.4.1.tgz >  /tmp/jmeter.tgz     && mkdir -p /opt     && tar -xvf /tmp/jmeter.tgz -C /opt     && rm /tmp/jmeter.tgz     && cd /etc/supervisor/conf.d     && echo '[program:jmeter]' >> supervisord.conf     && echo 'command=/opt/apache-jmeter-5.4.1/bin/./jmeter' >> supervisord.conf     && echo 'autorestart=true' >> supervisord.conf
 ---> Running in 65890128529d
fetch http://dl-cdn.alpinelinux.org/alpine/edge/main/x86_64/APKINDEX.tar.gz
WARNING: Ignoring http://dl-cdn.alpinelinux.org/alpine/edge/main/x86_64/APKINDEX.tar.gz: UNTRUSTED signature
fetch http://dl-cdn.alpinelinux.org/alpine/edge/community/x86_64/APKINDEX.tar.gz
WARNING: Ignoring http://dl-cdn.alpinelinux.org/alpine/edge/community/x86_64/APKINDEX.tar.gz: UNTRUSTED signature
fetch http://dl-3.alpinelinux.org/alpine/edge/testing/x86_64/APKINDEX.tar.gz
WARNING: Ignoring http://dl-3.alpinelinux.org/alpine/edge/testing/x86_64/APKINDEX.tar.gz: UNTRUSTED signature
ERROR: unsatisfiable constraints:
  curl (missing):
    required by: world[curl]
  openjdk8-jre (missing):
    required by: world[openjdk8-jre]
The command '/bin/sh -c apk add --no-cache curl openjdk8-jre bash     && curl -L https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.4.1.tgz >  /tmp/jmeter.tgz     && mkdir -p /opt     && tar -xvf /tmp/jmeter.tgz -C /opt     && rm /tmp/jmeter.tgz     && cd /etc/supervisor/conf.d     && echo '[program:jmeter]' >> supervisord.conf     && echo 'command=/opt/apache-jmeter-5.4.1/bin/./jmeter' >> supervisord.conf     && echo 'autorestart=true' >> supervisord.conf' returned a non-zero code: 2
```


`docker build -t jmeter .`{{exec}}


`docker run -it --rm -p 8080:8080 jmeter`{{exec}}
