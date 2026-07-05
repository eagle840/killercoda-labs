# Hello World! with Chromadb

`pip install ipython`{{exec}}

`ipython`{{exec}}

We'll be following the getting started guide https://docs.trychroma.com/getting-started#1-install

## Get Chroma Client

```
import chromadb
chroma_client = chromadb.Client()
```{{exec}}

## Create a Collection

```
collection = chroma_client.create_collection(name="my_collection")
```{{exec}}

## Add some text documents to the collection


```
collection.add(
    documents=["This is a document", "This is another document"],
    metadatas=[{"source": "my_source"}, {"source": "my_source"}],
    ids=["id1", "id2"]
)
```{{exec}}

## Query the collection

```
results = collection.query(
    query_texts=["This is a query document"],
    n_results=2
)

print(results)
```{{exec}}



