
# stored procedcured

**Writing stored procedures**
Stored procedures can create, update, read, query, and delete items inside an Azure Cosmos container. Stored procedures are registered per collection, and can operate on any document or an attachment present in that collection.

Here's a simple stored procedure that returns a "Hello World" response.

JavaScript

Copy
```
var helloWorldStoredProc = {
    id: "helloWorld",
    serverScript: function () {
        var context = getContext();
        var response = context.getResponse();

        response.setBody("Hello, World");
    }
}
```

The context object provides access to all operations that can be performed in Azure Cosmos DB, and access to the request and response objects. In this case, you use the response object to set the body of the response to be sent back to the client.

---

**Create an item using stored procedure**
When you create an item by using a stored procedure, the item is inserted into the Azure Cosmos DB container and an ID for the newly created item is returned. Creating an item is an asynchronous operation and depends on the JavaScript callback functions. The callback function has two parameters: one for the error object in case the operation fails, and another for a return value, in this case, the created object. Inside the callback, you can either handle the exception or throw an error. If a callback isn't provided and there's an error, the Azure Cosmos DB runtime throws an error.

The stored procedure also includes a parameter to set the description as a boolean value. When the parameter is set to true and the description is missing, the stored procedure throws an exception. Otherwise, the rest of the stored procedure continues to run.

This stored procedure takes as input documentToCreate, the body of a document to be created in the current collection. All such operations are asynchronous and depend on JavaScript function callbacks.

JavaScript

Copy
```
var createDocumentStoredProc = {
    id: "createMyDocument",
    body: function createMyDocument(documentToCreate) {
        var context = getContext();
        var collection = context.getCollection();
        var accepted = collection.createDocument(collection.getSelfLink(),
              documentToCreate,
              function (err, documentCreated) {
                  if (err) throw new Error('Error' + err.message);
                  context.getResponse().setBody(documentCreated.id)
              });
        if (!accepted) return;
    }
}
```
