# Step 3 Embeddings

https://docs.trychroma.com/embeddings

https://www.sbert.net/

## install all-MiniLM-L6-v2

We'll run the install inside ipython

`%pip install pip install -U sentence-transformers`{{exec}}

why isn't it:

`!pip install -U sentence-transformers`{{exec}}

`%pip install -U sentence-transformers`{{exec}}



you might have to install this outside of ipython

`pip install -U sentence-transformers`{{exec}}

`pip install sentence-transformers`{{exec}}


It'll take a few minutes to install the packages,


```
from sentence_transformers import SentenceTransformer
model = SentenceTransformer('all-MiniLM-L6-v2')

#Our sentences we like to encode
sentences = ['This framework generates embeddings for each input sentence',
    'Sentences are passed as a list of string.',
    'The quick brown fox jumps over the lazy dog.']

#Sentences are encoded by calling model.encode()
embeddings = model.encode(sentences)

#Print the embeddings
for sentence, embedding in zip(sentences, embeddings):
    print("Sentence:", sentence)
    print("Embedding:", embedding)
    print("")
```{{copy}}

It'll take a few minutes to install the above model,


## Comparing Sentence Similarities

https://www.sbert.net/docs/quickstart.html#comparing-sentence-similarities

```
from sentence_transformers import SentenceTransformer, util
model = SentenceTransformer('all-MiniLM-L6-v2')

#Sentences are encoded by calling model.encode()
emb1 = model.encode("This is a red cat with a hat.")
emb2 = model.encode("Have you seen my red cat?")

cos_sim = util.cos_sim(emb1, emb2)
print("Cosine-Similarity:", cos_sim)
```{{exec}}
