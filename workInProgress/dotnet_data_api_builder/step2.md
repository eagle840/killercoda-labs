# Continue api builder


https://learn.microsoft.com/en-gb/azure/data-api-builder/quickstart-sql#install-the-data-api-builder-cli


`dotnet tool install --global Microsoft.DataApiBuilder`{{exec}}

`dotnet tool list --global`{{exec}}

```
cat << \EOF >> ~/.bash_profile
# Add .NET Core SDK tools
export PATH="$PATH:/root/.dotnet/tools"
EOF
```{{exec}}

`export PATH="$PATH:/root/.dotnet/tools"`{{exec}}



https://learn.microsoft.com/en-gb/azure/data-api-builder/quickstart-sql#create-configuration-files


`dab init --database-type "mssql" --host-mode "Development" --connection-string "Server=localhost,1433;User Id=sa;Database=bookshelf;Password=<your-password>;TrustServerCertificate=True;Encrypt=True;"`

`dab init --database-type "mssql" --host-mode "Development" --connection-string "Server=localhost,1433;User Id=sa;Database=bookshelf;Password=MyP@ssW0rd;TrustServerCertificate=True;Encrypt=True;"`{{exec}}


`dab add Author --source "dbo.authors" --permissions "anonymous:*"`{{exec}}

### Test API with the local database


`dab start`{{exec}}
