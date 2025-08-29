# basic usage


`sqlcmd -?`{{exec}}

`sqlcmd create mssql --accept-eula --using https://aka.ms/AdventureWorksLT.bak`{{exec}}

`sqlcmd query "SELECT @@version"`{{exec}}

   ## format for veritcal output


`sqlcmd   query "SELECT @@SERVERNAME"`{{exec}}

VS

`sqlcmd   query "SELECT @@SERVERNAME"  -F vertical`{{exec}}

`sqlcmd  -Q "SELECT @@SERVERNAME"  -F vertical`{{exec}}

   ## list of avaiable images

`sqlcmd create mssql get-tags`{{exec}}

`sqlcmd   query "SELECT @@SERVERNAME"  --vertical`{{exec}}

`sqlcmd -Q "sp_databases" -F vertical`{{exec}}

`sqlcmd -Q "sp_tables" -F vertical`{{exec}}


```bash
sqlcmd query <<EOF
USE AdventureWorksLT;
SELECT CustomerID, CustomerName
FROM dbo.Customers
WHERE Country = 'UK';
GO
EOF
```{{exec}}

does this work
sqlcmd query --file multi_line_query.sql  # looks like it might -i script.sql
