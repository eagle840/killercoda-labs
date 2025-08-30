# MS Go-sqlcmd

**reference** https://www.youtube.com/watch?v=MlA1dAeE91A

## Install SQL Server Command Line Tools

Install the modern GO-based sqlcmd tool to connect to SQL Server.

**Reference**: https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools?view=sql-server-ver17&tabs=redhat-install

**Reference** https://learn.microsoft.com/en-us/sql/tools/sqlcmd/sqlcmd-utility?view=sql-server-ver17&tabs=go%2Cwindows-support&pivots=cs1-bash

Check your Ubuntu version:

`cat /etc/os-release`{{exec}}

**Setup GO-based sqlcmd**

Install the Microsoft repository key:



`curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc`{{exec}}

Add the Microsoft package repository:

`sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/22.04/prod.list)"`{{exec}}

Update package list and install the modern sqlcmd:

`sudo apt-get update`{{exec}}

`sudo apt-get install -y sqlcmd`{{exec}}

Add sqlcmd to your PATH:

`echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc`{{exec}}

`source ~/.bashrc`{{exec}}

Verify installation:

`sqlcmd -?`{{exec}}

 `sqlcmd create mssql --accept-eula --using https://aka.ms/AdventureWorksLT.bak`{{exec}}

 confirm the sever is running

 `docker ps`{{exec}}

## Test SQL Server Connection

Connect to SQL Server using the GO-based sqlcmd:

`sqlcmd query`{{exec}}

Test the connection by checking the SQL Server version:

```sql
SELECT @@VERSION;
GO
```{{exec}}

to exit:

`exit`{{exec}}

## Formated output in shell

To get a much better output while in shell,

`sqlcmd -y 30 -Y 30`{{exec}}
