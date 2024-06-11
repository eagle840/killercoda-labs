
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

https://dotnet.microsoft.com/en-us/learn

# Install dependencies


`sudo apt update`{{exec}}

`apt install -y curl git sqlite3 libpq-dev libreadline-dev`{{exec}}

`apt install net-tools`{{exec}}

## Manual Install dotnet


`wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb`{{exec}}

`sudo dpkg -i packages-microsoft-prod.deb`{{exec}}

`rm packages-microsoft-prod.deb`{{exec}}

 `sudo apt-get update &&   sudo apt-get install -y dotnet-sdk-8.0`{{exec}}

`dotnet --version`{{exec}}

## start Sql Database

Taken form [MicroSoft](https://learn.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-ver16&tabs=cli&pivots=cs1-bash)

`sudo docker pull mcr.microsoft.com/mssql/server:2022-latest`{{exec}}

WIP --network host

```
sudo docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=<YourStrong@Passw0rd>" \
   -p 1433:1433 --name sql1 --hostname sql1 \
   -d \
   mcr.microsoft.com/mssql/server:2022-latest
```{{exec}}


```
sudo docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=<YourStrong@Passw0rd>" \
   -p 1433:1433 --name sql1 --hostname sql1 \
   -d --network host \
   mcr.microsoft.com/mssql/server:2022-latest
```{{copy}}

```
sudo docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=<YourStrong@Passw0rd>" \
   -p 1433:1433 --name sql1 --hostname sql1 \
   -d \
   mcr.microsoft.com/mssql/server:2022-latest
```{{copy}}


`netstat -tpln`{{exec}}



confirm connection

`curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -`{{exec}}

`sudo add-apt-repository "$(curl -s https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list)"`{{exec}}

`sudo apt-get update`{{exec}}

`sudo apt-get install mssql-tools unixodbc-dev`{{exec}}

`echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc`{{exec}}

`source ~/.bashrc`{{exec}}

`sqlcmd -S localhost -U sa -P '<YourStrong@Passw0rd>' -Q "SELECT @@VERSION"`{{exec}}


- `-Q`: This option specifies that the following string is a query to be executed. The query is executed and the results are returned to the command line.
- `"SELECT @@VERSION"`: This is the SQL query itself. `SELECT @@VERSION` is a system function in SQL Server that returns the version, edition, and build information for the SQL Server instance

`sqlcmd -S localhost -U sa -P 'MyStrong@Passw0rd' -Q "CREATE DATABASE Demo"`{{exec}}

Note in this type of server, use newlin & GO instead of ;