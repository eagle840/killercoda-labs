# sdk

https://learn.microsoft.com/en-us/training/modules/work-with-cosmos-db/3-exercise-work-cosmos-db-dotnet


`mkdir az204-cosmos`{{exec}}

`cd az204-cosmos`{{exec}}

`dotnet new console`{{exec}}

`dotnet add package Microsoft.Azure.Cosmos`{{exec}}

`dotnet add package Newtonsoft.Json --version 13.0.3`{{exec}}

`<PackageReference Include="Newtonsoft.Json" Version="10.0.2" />`

Delete any existing code in the Program.cs file and add the using Microsoft.Azure.Cosmos statement.

**SEE BELOW FOR WORKING CODE**

```
using Microsoft.Azure.Cosmos;
```

after, add

```
public class Program
{
    // Replace <documentEndpoint> with the information created earlier
    private static readonly string EndpointUri = "<documentEndpoint>";

    // Set variable to the Primary Key from earlier.
    private static readonly string PrimaryKey = "<your primary key>";

    // The Cosmos client instance
    private CosmosClient cosmosClient;

    // The database we will create
    private Database database;

    // The container we will create.
    private Container container;

    // The names of the database and container we will create
    private string databaseId = "az204Database";
    private string containerId = "az204Container";

    public static async Task Main(string[] args)
    {
        try
        {
            Console.WriteLine("Beginning operations...\n");
            Program p = new Program();
            await p.CosmosAsync();

        }
        catch (CosmosException de)
        {
            Exception baseException = de.GetBaseException();
            Console.WriteLine("{0} error occurred: {1}", de.StatusCode, de);
        }
        catch (Exception e)
        {
            Console.WriteLine("Error: {0}", e);
        }
        finally
        {
            Console.WriteLine("End of program, press any key to exit.");
            Console.ReadKey();
        }
    }
    //The sample code below gets added below this line
}
```

after, add

```
public async Task CosmosAsync()
{
    // Create a new instance of the Cosmos Client
    this.cosmosClient = new CosmosClient(EndpointUri, PrimaryKey);

    // Runs the CreateDatabaseAsync method
    await this.CreateDatabaseAsync();

    // Run the CreateContainerAsync method
    await this.CreateContainerAsync();
}
```


## Create DB
Copy and paste the CreateDatabaseAsync method after the CosmosAsync method. CreateDatabaseAsync creates a new database with ID az204Database if it doesn't already exist.
```
private async Task CreateDatabaseAsync()
{
    // Create a new database using the cosmosClient
    this.database = await this.cosmosClient.CreateDatabaseIfNotExistsAsync(databaseId);
    Console.WriteLine("Created Database: {0}\n", this.database.Id);
}
```

## Create container
Copy and paste the CreateContainerAsync method below the CreateDatabaseAsync method.
```
private async Task CreateContainerAsync()
{
    // Create a new container
    this.container = await this.database.CreateContainerIfNotExistsAsync(containerId, "/LastName");
    Console.WriteLine("Created Container: {0}\n", this.container.Id);
}
```

## Run the App

This is a console app, so I don;t think you need to set a http endpoint

`dotnet run`{{exec}}

`dotnet run --urls http://0.0.0.0:5000`{{exec}}

wip `dotnet watch -v --urls http://0.0.0.0:5000`{{exec}}

---
The following code runs, but does what?

```
using Microsoft.Azure.Cosmos;
using System;
using System.Threading.Tasks;

public class Program
{
    // Replace <documentEndpoint> with the information created earlier
    private static readonly string EndpointUri = "URL ENDPOINT";

    // Set variable to the Primary Key from earlier.
    private static readonly string PrimaryKey = "KEY";

    // The Cosmos client instance
    private CosmosClient cosmosClient;

    // The database we will create
    private Database database;

    // The container we will create.
    private Container container;

    // The names of the database and container we will create
    private string databaseId = "az204Database";
    private string containerId = "az204Container";

    public static async Task Main(string[] args)
    {
        try
        {
            Console.WriteLine("Beginning operations...\n");
            Program p = new Program();
            await p.CosmosAsync();

        }
        catch (CosmosException de)
        {
            Exception baseException = de.GetBaseException();
            Console.WriteLine("{0} error occurred: {1}", de.StatusCode, de);
        }
        catch (Exception e)
        {
            Console.WriteLine("Error: {0}", e);
        }
        finally
        {
            Console.WriteLine("End of program, press any key to exit.");
            Console.ReadKey();
        }
    }

    // Method to initialize CosmosClient and create database and container
    public async Task CosmosAsync()
    {
        // Create a new instance of the Cosmos Client
        this.cosmosClient = new CosmosClient(EndpointUri, PrimaryKey);

        // Run the CreateDatabaseAsync method
        await this.CreateDatabaseAsync();

        // Run the CreateContainerAsync method
        await this.CreateContainerAsync();
    }

    private async Task CreateDatabaseAsync()
    {
        // Create a new database using the cosmosClient
        this.database = await this.cosmosClient.CreateDatabaseIfNotExistsAsync(databaseId);
        Console.WriteLine("Created Database: {0}\n", this.database.Id);
    }

    private async Task CreateContainerAsync()
    {
        // Create a new container using the database instance
        this.container = await this.database.CreateContainerIfNotExistsAsync(containerId, "/yourPartitionKey");
        Console.WriteLine("Created Container: {0}\n", this.container.Id);
    }
}

```{{copy}}
