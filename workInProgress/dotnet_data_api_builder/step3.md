# blank


WIP WIP redis and azurite#


Cosmos and graphql

Create an azure cosmos db

Create a db bookshelf

create a collection (table) authors
https://learn.microsoft.com/en-us/azure/data-api-builder/quickstart-nosql


`touch schema.graphql`{{exec}}

```
type Author @model {
  id: ID!
  firstName: String!
  middleName: String
  lastName: String!
}
```{{copy}}


`dab init --database-type "cosmosdb_nosql" --host-mode "Development" --cosmosdb_nosql-database bookshelf --graphql-schema schema.graphql --connection-string "CONNECT_STRING"`


`dab add Author --source "authors" --permissions "anonymous:*"`{{exec}}

`cat dab-config.json`{{exec}}


`DOTNET_URLS=http://0.0.0.0:5000 dab start`{{exec}}

{{TRAFFIC_HOST1_5000}}/graphql

WIP

what do I get if I hit:
{{TRAFFIC_HOST1_5000}}

{{TRAFFIC_HOST1_5000}}/swagger

{{TRAFFIC_HOST1_5000}}/graphql

{{TRAFFIC_HOST1_5000}}/api/Author

Run query

```
query {
  authors {
    items {
      id
      firstName
      lastName
    }
  }
}
```

```
mutation {
  createAuthor(item: {
    id: "003",
    firstName: "Jane",
    lastName: "Doe"
  }) {
    id
    firstName
    lastName
  }
}
```

https://learn.microsoft.com/en-us/azure/cosmos-db/how-to-migrate-desktop-tool?tabs=azure-cli

data
```
[
  {
    "id": "01",
    "firstName": "Henry",
    "lastName": "Ross"
  },
  {
    "id": "02",
    "firstName": "Jacob",
    "middleName": "A.",
    "lastName": "Hancock"
  },
  {
    "id": "03",
    "firstName": "Sydney",
    "lastName": "Mattos"
  },
  {
    "id": "04",
    "firstName": "Jordan",
    "lastName": "Mitchell"
  },
  {
    "id": "05",
    "firstName": "Victoria",
    "lastName": "Burke"
  },
  {
    "id": "06",
    "firstName": "Vance",
    "lastName": "DeLeon"
  },
  {
    "id": "07",
    "firstName": "Reed",
    "lastName": "Flores"
  },
  {
    "id": "08",
    "firstName": "Felix",
    "lastName": "Henderson"
  },
  {
    "id": "09",
    "firstName": "Avery",
    "lastName": "Howard"
  },
  {
    "id": "10",
    "firstName": "Violet",
    "lastName": "Martinez"
  }
]
```
