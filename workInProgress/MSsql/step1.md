# Docker compose


create the file: docker-compose.yml  and paste the yaml file in.

`nano docker-compose.yml`{{execute}}

(ctrl-insert:copy shift-insert:paste)

WIP whi is it running on 3308, and not default 3306

```yaml
version: '3'

services:

  mssql-dev:
    image: mcr.microsoft.com/mssql/server:2025-latest
    environment:
      SA_PASSWORD: "YourStrong!Passw0rd"
      ACCEPT_EULA: "Y"
      MSSQL_PID: "Developer"
    ports:
      - "1433:1433"
    volumes:
      - "./mssql-data:/var/opt/mssql"
```


lets copy across the data folder we created in step 1

WIP, not using this.

`cp -r /root/data/ /root/compose1/data/`

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

### Adminer tool

Lets add the Adminer tool to the yml so we can administor those databases:

``` yaml
    admin:
        image: adminer
        ports:
        - 8080:8080
```

make the port 0.0.0.0:8080

`nano docker-compose.yml`{{execute}}

`docker-compose up -d `{{execute}}

And lets connect and login:


{{TRAFFIC_HOST1_8080}}

Here's the login for the MySQL server. You can get the server name from using `docker-compose ps`

```
system: ms-sql
server: root_mssql-dev_1   (name from `docker-compose ps`)
un: sa
pw: YourStrong!Passw0rd
database: test1 (you can leave blank)
```



# WIP: Setup and create a simple DB

In this step will setup MySQL in docker and use local storage:

Lets jump over to docker hub and search for an mysql mage https://hub.docker.com/
You should end up here: https://hub.docker.com/_/mysql, we'll be using version 8.0.2 to keep things stable.

Looking through the notes you'll see  how to startup mysql,

`docker run --name some-mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=1234 -d mysql:8.0.2`{{execute}}

It'll take a minute to pull the image, so wait until you see a container up and running with

`docker ps`{{execute}}

## Connect to MS SQL

https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools?view=sql-server-ver17&tabs=redhat-install

`cat /etc/os-release`{{exec}}

`sudo apt-get install mssql-tools`{{exec}}

It also takes a few seconds to get MySQL up and running, if you get an error wait a few seconds and try again.

`curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc`{{exec}}

`curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list`{{exec}}

`sudo apt-get update`{{exec}}

`sudo apt-get install mssql-tools18 unixodbc-dev`{{exec}}

`echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bash_profile`{{exec}}

`source ~/.bash_profile`{{exec}}

`sqlcmd -?`{{exec}}

`docker exec -it  some-mysql mysql -uroot -p1234`{{execute}}

`docker exec -it root_mssql-dev_1 /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "YourStrong!Passw0rd"`{{exec}}


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

NOTE: that the sql server wass started on 3308 (not the default 3306) WHY?

`mysql -h 0.0.0.0  -P3308  -uroot -p1234 --ssl-mode=disabled`{{execute}}


`SOURCE ./sakila-db/sakila-schema.sql;`{{exec}}

`SOURCE ./sakila-db/sakila-data.sql;`{{exec}}



`USE sakila;`{{exec}}

`SHOW FULL TABLES;`{{exec}}

`SELECT COUNT(*) FROM film;`{{exec}}

`SELECT COUNT(*) FROM film_text;`{{exec}}


review https://dev.mysql.com/doc/sakila/en/sakila-usage.html  from more commands

## Adding users

You can add users in MySQL using the `CREATE USER` statement and grant them privileges with `GRANT`. Here's how:

### 1. **Create a New User**
```sql
CREATE USER 'new_user'@'localhost' IDENTIFIED BY 'secure_password';
```
Replace `'new_user'` with the desired username and `'secure_password'` with a strong password.

### 2. **Grant Privileges**
```sql
GRANT ALL PRIVILEGES ON database_name.* TO 'new_user'@'localhost';
```
This grants full access to a specific database. Replace `database_name` with the actual database name.

### 3. **Apply Changes**
```sql
FLUSH PRIVILEGES;
```
This ensures MySQL applies the new permissions.

### 4. **Verify User**
```sql
SELECT user FROM mysql.user;
```
This lists all users in MySQL.

For more details, check out [this guide](https://www.digitalocean.com/community/tutorials/how-to-create-a-new-user-and-grant-permissions-in-mysql) or [MySQL's official documentation](https://dev.mysql.com/doc/refman/9.3/en/creating-accounts.html). Let me know if you need help with specific permissions!

## For root access

You can create another user with root-level access in MySQL by granting them **all privileges** and the ability to grant permissions to others. Here's how:

### 1. **Create the User**
```sql
CREATE USER 'new_root_user'@'localhost' IDENTIFIED BY 'strong_password';
```
Replace `'new_root_user'` with the desired username and `'strong_password'` with a secure password.

### 2. **Grant Root-Level Privileges**
```sql
GRANT ALL PRIVILEGES ON *.* TO 'new_root_user'@'localhost' WITH GRANT OPTION;
```
This gives the user full control over all databases and the ability to grant privileges to others.

### 3. **Apply Changes**
```sql
FLUSH PRIVILEGES;
```
This ensures MySQL applies the new permissions.

### 4. **Verify User**
```sql
SELECT user, host FROM mysql.user;
```
This lists all users and their access levels.

If you need remote access, you can replace `'localhost'` with `'%'` to allow connections from any host, but be cautious with security settings. You can also check out [this guide](https://www.digitalocean.com/community/tutorials/how-to-create-a-new-user-and-grant-permissions-in-mysql) for more details. Let me know if you need help configuring access!
