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

`apt install mysql-client`{{execute}}

`mysql -h 0.0.0.0  -P3306  -uroot -p1234 --ssl-mode=disabled`{{execute}}

# create a db

now we're connected lets create a new database.

`show databases;`{{execute}}

`create database test1;`{{execute}}

`show databases;`{{execute}}

and exit mysql/container

`exit;`{{execute}}

(need some help on sql? try: https://www.w3schools.com/sql/default.asp or https://learnxinyminutes.com/docs/sql/)

lets stop and remove the container

`docker stop some-mysql`{{execute}}

`docker rm some-mysql `{{execute}}

and start it again so  the database is preserved on a local volume
`mkdir data`{{execute}}

`docker run --name some-mysql -v /root/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=1234 -d mysql:8.0.2`{{execute}}

wait 30 seconds and connect to the container:

`docker exec -it  some-mysql mysql -uroot -p1234`{{execute}}

You should see the prompt: 'mysql>'

`create database test1;`{{execute}}

## Create  a couple of simple tables.

`use test1;`{{execute}}

`CREATE TABLE Persons (PersonID int, LastName varchar(255), FirstName varchar(255), Address varchar(255), City varchar(255) );`{{execute}}


`SELECT * FROM Persons;`{{execute}}

`INSERT INTO Persons VALUES ('4006', 'Smith', 'John', '123 any street', 'anywhere');`{{execute}}

`SELECT * FROM Persons;`{{execute}}

and now exit and deletel the container:

`exit;`{{execute}}

`docker stop some-mysql`{{execute}}

`docker rm some-mysql `{{execute}}

If you take a look in the data folder you'll see the files created my mysql

`ls data`{{execute}}

## Import northwinds


Importing north winds

`cd ~`{{execute}}

`git clone https://github.com/dalers/mywind.git`{{execute}}

`cd mywind/`{{execute}}

`docker cp northwind.sql some-mysql:/northwind.sql`{{execute}}

`docker exec -it some-mysql  mysql -u root -p`{{execute}}

`1234`{{execute}}

`source /northwind.sql;`{{execute}}


`SHOW DATABASES;`{{execute}}
