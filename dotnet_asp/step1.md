
# Initial Setup


## Install dependencies


`sudo apt update`{{exec}}

`apt install -y curl git sqlite3 libpq-dev libreadline-dev`{{exec}}

`apt install net-tools`{{exec}}

## Manual Install dotnet


`wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb`{{exec}}

`sudo dpkg -i packages-microsoft-prod.deb`{{exec}}

`rm packages-microsoft-prod.deb`{{exec}}

 `sudo apt-get update &&   sudo apt-get install -y dotnet-sdk-8.0`{{exec}}

`dotnet --version`{{exec}}

## Start Sql Database

Taken form [Microsoft](https://learn.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-ver16&tabs=cli&pivots=cs1-bash)

`sudo docker pull mcr.microsoft.com/mssql/server:2022-latest`{{exec}}


```
sudo docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=<YourStrong@Passw0rd>" \
   --name sql1 --hostname sql1 \
   --network host \
   -d \
   mcr.microsoft.com/mssql/server:2022-latest
```{{exec}}

Confirm that port 1433 comes up, may take a minute:

`netstat -tpln`{{exec}}



confirm connection

`curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -`{{exec}}

`sudo add-apt-repository "$(curl -s https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list)"`{{exec}}

WIP `sudo apt-get update`{{copy}}

`sudo apt-get install mssql-tools unixodbc-dev -y`{{exec}}

`echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc`{{exec}}

`source ~/.bashrc`{{exec}}

`sqlcmd -S localhost -U sa -P '<YourStrong@Passw0rd>' -Q "SELECT @@VERSION"`{{exec}}


- `-Q`: This option specifies that the following string is a query to be executed. The query is executed and the results are returned to the command line.
- `"SELECT @@VERSION"`: This is the SQL query itself. `SELECT @@VERSION` is a system function in SQL Server that returns the version, edition, and build information for the SQL Server instance


WIP:   
`sqlcmd -S localhost -U sa -P '<YourStrong@Passw0rd>' -Q "CREATE DATABASE Demo"`{{ecopy}}

Note in this type of server, use newlin & GO instead of ;