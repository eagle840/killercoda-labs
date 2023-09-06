# Hello World! using python



`pip install weaviate-client`{{exec}}

`pip install ipython`{{exec}}

`pip install openai`{{exec}}


`ipython`{{exec}}

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
    "vectorizer": "text2vec-openai",  # If set to "none" you must always provide vectors yourself. Could be any other "text2vec-*" also.
    "moduleConfig": {
        "text2vec-openai": {},
        "generative-openai": {}  # Ensure the `generative-openai` module is used for generative queries
    }
}

client.schema.create_class(class_obj)
```{{exec}}

# Add objects

WIP Getting error
```
{'error': [{'message': 'update vector: API Key: no api key found neither in request header: X-Openai-Api-Key nor in environment variable under OPENAI_APIKEY'}]}
```


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

# Generative search (single prompt)
```
response = (
    client.query
    .get("Question", ["question", "answer", "category"])
    .with_near_text({"concepts": ["biology"]})
    .with_generate(single_prompt="Explain {answer} as you might to a five-year-old.")
    .with_limit(2)
    .do()
)

print(json.dumps(response, indent=4))
```{{exec}}

# Generative search (grouped task)
```
response = (
    client.query
    .get("Question", ["question", "answer", "category"])
    .with_near_text({"concepts": ["biology"]})
    .with_generate(grouped_task="Write a tweet with emojis about these facts.")
    .with_limit(2)
    .do()
)

print(response["data"]["Get"]["Question"][0]["_additional"]["generate"]["groupedResult"])
```{{exec}}

This ends the lab



