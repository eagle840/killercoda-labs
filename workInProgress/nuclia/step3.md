# Step 3

# Using Generative LLM's

The following code needs a LLM to be added to the config. - Work in progress


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