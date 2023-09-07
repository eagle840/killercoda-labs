# Hello World! Baiic use of Weaviate


We'll be following the [quickstart guide](https://weaviate.io/developers/weaviate/quickstart), but with some alterations. 


`pip install weaviate-client`{{exec}}

`pip install ipython`{{exec}}

`ipython`{{exec}}

You'll need to enter return on each piece of python code:

```
import weaviate
import json
```{{exec}}

# Connect to Weaviate
```
client = weaviate.Client(
    url = "http://localhost:8080",  # Replace with your endpoint
)
```{{exec}}

# Define a class
```
class_obj = {
    "class": "Question",
    "vectorizer": "text2vec-contextionary",  # If set to "none" you must always provide vectors yourself. Could be any other "text2vec-*" also.
    "moduleConfig": {
        "text2vec-contextionary": {}
    }
}

client.schema.create_class(class_obj)
```{{exec}}

# Add objects

```
import requests
resp = requests.get('https://raw.githubusercontent.com/weaviate-tutorials/quickstart/main/data/jeopardy_tiny.json')
data = json.loads(resp.text)  # Load data

client.batch.configure(batch_size=100)  # Configure batch
with client.batch as batch:  # Initialize a batch process
    for i, d in enumerate(data):  # Batch import data
        print(f"importing question: {i+1}")
        properties = {
            "answer": d["Answer"],
            "question": d["Question"],
            "category": d["Category"],
        }
        batch.add_data_object(
            data_object=properties,
            class_name="Question"
        )
```{{exec}}


# Queries

```
response = (
    client.query
    .get("Question", ["question", "answer", "category"])
    .with_near_text({"concepts": ["biology"]})
    .with_limit(2)
    .do()
)

print(json.dumps(response, indent=4))
```{{exec}}

# Semantic search with a filter
```
response = (
    client.query
    .get("Question", ["question", "answer", "category"])
    .with_near_text({"concepts": ["biology"]})
    .with_where({
        "path": ["category"],
        "operator": "Equal",
        "valueText": "ANIMALS"
    })
    .with_limit(2)
    .do()
)

print(json.dumps(response, indent=4))
```{{exec}}


For more tutorials, see https://weaviate.io/developers/weaviate/tutorials

This ends the lab



