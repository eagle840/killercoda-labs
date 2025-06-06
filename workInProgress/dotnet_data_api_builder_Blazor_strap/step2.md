# API builder


https://learn.microsoft.com/en-gb/azure/data-api-builder/quickstart-sql#install-the-data-api-builder-cli

## Install API builder

`dotnet tool install --global Microsoft.DataApiBuilder`{{exec}}

`dotnet tool list --global`{{exec}}

`export PATH="$PATH:/root/.dotnet/tools"`{{exec}}




## DAB's components:

- Source data
- Configuration file: dab-config.json
- Data API Builder Runtime
- REST and GraphQL methods
- REST and GraphQL endpoints
  - https://localhost:5000/ -> health
  - https://localhost:5000/swagger
  - https://localhost:5000/api/<name>   CHECK THIS
  - http://localhost:5000/graphql

`dab --help`{{exec}}


https://learn.microsoft.com/en-gb/azure/data-api-builder/quickstart-sql#create-configuration-files

`dab init --database-type "mssql" --host-mode "Development" --connection-string "Server=localhost,1433;User Id=sa;Database=bookshelf;Password=MyP@ssW0rd;TrustServerCertificate=True;Encrypt=True;"`{{exec}}


Let review the created dab-config file:

`cat dab-config.json`{{exec}}


`dab add Author --source "dbo.authors" --permissions "anonymous:*"`{{exec}}

### Test API with the local database


WIP We'll change localhost -> 0.0.0.0

`dab start`{{copy}}

`DOTNET_URLS=http://0.0.0.0:5000 dab start`{{exec}}

{{TRAFFIC_HOST1_5000}}

{{TRAFFIC_HOST1_5000}}/swagger

{{TRAFFIC_HOST1_5000}}/graphql

{{TRAFFIC_HOST1_5000}}/api/Author

Open a new tab and run:

`curl -X 'GET' '{{TRAFFIC_HOST1_5000}}/api/Author' -H 'accept: application/json'`{{exec}}

note the format of the JSON

```JSON
{"value":[{"id":1,"first_name":"Henry","middle_name":null,"last_name":"Ross"},{"id":2,"first_name":"Jacob","middle_name":"A.","last_name":"Hancock"}]}
```
