#  Setup and create a simple DB

In this step will setup MySQL in docker and use local storage:

Lets jump over to docker hub and search for an mysql mage https://hub.docker.com/
You should end up here: https://hub.docker.com/_/mysql, we'll be using version 8.0.2 to keep things stable.

Looking through the notes you'll see  how to startup mysql, 

`docker run --name some-mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=1234 -d mysql:8.0.2`{{execute}}

It'll take a minute to pull the image, so wait until you see a container up and running with

`docker ps`{{execute}}  

## Connect to mySQL

It also takes a few seconds to get MySQL up and running, if you get an error wait a few seconds and try again.

`docker exec -it  some-mysql mysql -uroot -p1234`{{execute}} 

-uroot   => user root  
-p       => prompt for password, or -p1234

Once connected, you should see `mysql>`

Exit out of the prompt, back to the host, with `quit`{{execute}}

## To connect from the host

Lets install the mysql client:

`apt update`{{execute}}

`apt install mysql-client -y`{{execute}}

`mysql -h 0.0.0.0  -P3306  -uroot -p1234 --ssl-mode=disabled`{{execute}}

`quit`{{execute}}


## Use an example db

https://dev.mysql.com/doc/index-other.html > sakila database

entity relationship   https://dev.mysql.com/doc/sakila/en/sakila-structure.html

`wget https://downloads.mysql.com/docs/sakila-db.zip`{{exec}}

`unzip sakila-db.zip`{{exec}}

`mysql -h 0.0.0.0  -P3306  -uroot -p1234 --ssl-mode=disabled`{{execute}}


`SOURCE ./sakila-db/sakila-schema.sql;`{{exec}}

`SOURCE ./sakila-db/sakila-data.sql;`{{exec}}



`USE sakila;`{{exec}}

`SHOW FULL TABLES;`{{exec}}

`SELECT COUNT(*) FROM film;`{{exec}}

`SELECT COUNT(*) FROM film_text;`{{exec}}


review https://dev.mysql.com/doc/sakila/en/sakila-usage.html  from more commands
