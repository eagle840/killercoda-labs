# Docker compose


READ: https://learn.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-ver17&tabs=cli&pivots=cs1-bash

create the file: docker-compose.yml  and paste the yaml file in.

`nano docker-compose.yml`{{execute}}

(ctrl-insert:copy shift-insert:paste)



```yaml
version: '3'

services:

  mssql-dev:
    image: mcr.microsoft.com/mssql/server:2017-latest
    environment:
      SA_PASSWORD: "YourStrong!Passw0rd"
      ACCEPT_EULA: "Y"
      MSSQL_PID: "Developer"
    ports:
      - "1433:1433"
    volumes:
      - "./mssql-data:/var/opt/mssql"
```


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




## Connect to MS SQL

https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools?view=sql-server-ver17&tabs=redhat-install

`cat /etc/os-release`{{exec}}


**Setup to install**

`curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc`{{exec}}

`curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list`{{exec}}

`sudo apt-get update`{{exec}}

`sudo apt-get install mssql-tools18 unixodbc-dev`{{exec}}

`echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bash_profile`{{exec}}

`source ~/.bash_profile`{{exec}}

`sqlcmd -?`{{exec}}

`sqlcmd -C -S localhost -U sa -P 'YourStrong!Passw0rd'`{{exec}}

Confirm the connection

```
SELECT @@VERSION;
GO
```{{exec}}


`docker exec -it root_mssql-dev_1 /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'YourStrong!Passw0rd'`{{exec}}



`docker exec -it root_mssql-dev_1 /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "YourStrong!Passw0rd"`{{exec}}



## Connect via SSMS ???

is this the endpoint?

{{TRAFFIC_HOST1_1433}}

# Configure SQL Server on Linux with the mssql-conf tool

https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-configure-mssql-conf?view=sql-server-ver17
