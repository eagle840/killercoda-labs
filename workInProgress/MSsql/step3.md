# SQL Server Agent

Config in docker

`docker exec -it --user root mssql-dev_1 bash`{{exec}}


```
root@57301203bac5:/# /opt/mssql/bin/mssql-conf set sqlagent.enabled true
SQL Server needs to be restarted in order to apply this setting. Please run
'systemctl restart mssql-server.service'.
```

`/opt/mssql/bin/mssql-conf set sqlagent.enabled true`{{exec}}



`docker container restart mssql-dev_1`{{exec}}




https://learn.microsoft.com/en-us/ssms/agent/sql-server-agent


Install SQL Server Agent on Linux

https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-setup-sql-agent?view=sql-server-ver17&tabs=rhel


## SQL Server Full text search

https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-setup-full-text-search?view=sql-server-ver17&tabs=rhel


## Install SQL Server Integration Services (SSIS) on Linux

what is this?


https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-setup-ssis?view=sql-server-ver17&tabs=rhel

## JAVA extension


https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-setup-language-extensions-java?view=sql-server-ver17
