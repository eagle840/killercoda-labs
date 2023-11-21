## docker compose

In this step we'll be using docker-compose to start up of already created databases, show how we can run several databases at the same time and run Adminer to admin these databases.

Lets make sure we' re in the root folder

`cd /root`{{execute}}

first create a folder to hold your composer files:

`mkdir compose1 && cd compose1`{{execute}}

## Our first docker-compose instance

create the file: docker-compose.yml  and paste the yaml file in.

`nano docker-compose.yml`{{execute}}

(ctrl-insert:copy shift-insert:paste)


```yaml
version: '3'

services:

    mysql-dev:
        image: mysql:8.0.2
        environment:
            MYSQL_ROOT_PASSWORD: 1234
            MYSQL_DATABASE: test1
        ports:
           - "3308:3306"
        volumes:
           - "./data:/var/lib/mysql:rw"
```

lets copy across the data folder we created in step 1

`cp -r /root/data/ /root/compose1/data/`{{execute}}

and tell docker-compose to start up.

`docker-compose up -d`{{execute}}

and confirm it's running  
`docker-compose ps`{{execute}}


you can connect to the container in either way:  
`docker exec -it compose1_mysql-dev_1 /bin/bash`{{execute}}

OR

`docker-compose exec  mysql-dev /bin/bash`{{execute}}

and then exit the container when finished   
`exit`{{execute}}


## add 2nd & 3rd db to docker-compose.yml file

Add   the following  to the end of the docker-compose file.

`nano docker-compose.yml`{{execute}}

``` yaml
    client:
        image: mysql:8.0.2
        depends_on:
            - mysql-dev
        command: mysql -uroot -p1234 -hmysql-dev test1
```

`docker-compose up -d`{{execute}}

`docker-compose ps`{{execute}}

note that the client will exit

`docker-compose run --rm client`{{execute}}  

and `exit`{{execute}}

will connect you

`docker-compose ps`{{execute}}

shows a new container running 

Let's  add another legacy SQL server, but use a different port:

`nano docker-compose.yml`{{execute}}

``` yaml
    mysql-legacy:
        image: mysql:5.7
        environment:
            MYSQL_ROOT_PASSWORD: 1234
            MYSQL_DATABASE: 2014app
        ports:
        - "3309:3306"
```

`docker-compose up -d`{{execute}}

`docker-compose ps`{{execute}}

`docker-compose exec mysql-legacy mysql -uroot -p1234 2014app`{{execute}}

and `exit`{{execute}}


### Adminer tool

Lets add the Adminer tool to the yml so we can administor those databases:

``` yaml
    admin:
        image: adminer
        ports:
        - 8080:8080
```

`nano docker-compose.yml`{{execute}}

`docker-compose up -d `{{execute}}

And lets connect and login:


{{TRAFFIC_HOST1_8080}}

Here's the login for the MySQL server. You can get the server name from using `docker-compose ps`

```
system: mysql
server: compose1_mysql-dev_1   (from docker-compose ps)
un: root
pw: 1234
database: test1
```



## postgres

Add finally add a postgres if you are interested in working on that.

```yaml
    postgres1:
        image: postgres
        environment:
            POSTGRES_USER: root
            POSTGRES_PASSWORD: 1234
            POSTGRES_DB: blogapp
```

`docker-compose up -d`{{execute}}

`docker-compose ps`{{execute}}

try connecting with adminer

or connect with cli:

`docker-compose exec postgres1 psql -U root -W blogapp`{{execute}}




