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

the `--host-mode` flag specifies how the builder will host your APIs. There are typically three available host modes: 

1. **Development**: This mode is designed for local development purposes. It provides detailed error messages and debugging information to assist in the development process.

2. **Production**: This mode is optimized for deploying your application to a production environment. It focuses on performance and security, with reduced debugging information to ensure the smooth running of your application.

3. **Staging**: This mode is used for pre-production environments to test your application in a setting that closely mimics production. It helps identify any potential issues before the final deployment.
Let review the created dab-config file:

`cat dab-config.json`{{exec}}


`dab add Author --source "dbo.authors" --permissions "anonymous:*"`{{exec}}

Let's break down the `dab add` command you provided:

- **`dab add Author`**: This part of the command tells the Data API Builder (DAB) to add a new endpoint named `Author`. The name can be anything you choose, but it's typically named after the resource or entity you are working with.

- **`--source "dbo.authors"`**: This flag specifies the data source for the new endpoint. In this case, the source is the `authors` table in the `dbo` schema of your database. This means that the `Author` endpoint will interact with the data in the `authors` table.

- **`--permissions "anonymous:*"`**: This flag sets the permissions for the new endpoint. By specifying `anonymous:*`, you are allowing anonymous users to access all operations (`*` signifies all operations) on the `Author` endpoint. This means that anyone, without needing to be authenticated, can perform actions such as reading, creating, updating, and deleting records through this endpoint.


note the changes in the config file:

`cat dab-config.json`{{exec}}

### Test API with the local database


WIP We'll change localhost -> 0.0.0.0

If we wanted to start locally, we'd use`dab start`{{copy}}

But on Killacoda:

`DOTNET_URLS=http://0.0.0.0:5000 dab start`{{exec}}

{{TRAFFIC_HOST1_5000}}

{{TRAFFIC_HOST1_5000}}/swagger

{{TRAFFIC_HOST1_5000}}/graphql

{{TRAFFIC_HOST1_5000}}/api/Author

In future versions we'll add redis and noSql.
