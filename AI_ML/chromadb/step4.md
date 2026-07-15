# Step 4 - Putting it all together

In this final step, we will combine what we learned: generate embeddings for documents and store them directly in the Chromadb collection.

## Generate Embeddings and Persist

```python
import chromadb
from sentence_transformers import SentenceTransformer

# Initialize client and model
chroma_client = chromadb.Client()
collection = chroma_client.create_collection(name="embedding_collection")
model = SentenceTransformer('all-MiniLM-L6-v2')

# Documents to add
docs = [
    "Machine learning is fascinating.",
    "Chromadb is a vector database.",
    "Sentence transformers simplify embedding creation."
]

# Generate embeddings
embeddings = model.encode(docs)

# Add to collection
collection.add(
    documents=docs,
    embeddings=embeddings.tolist(),
    ids=["id1", "id2", "id3"]
)

# Verify storage
print(f"Collection count: {collection.count()}")


```{{exec}}

## And query the db


```python
# Query
results = collection.query(
    query_texts=["What is Chromadb?"],
    n_results=1
)
print(f"Query results: {results['documents']}")
```{{exec}}


