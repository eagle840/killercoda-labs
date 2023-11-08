# Redis Stack

## Overview

The major components of Redis Stack include:

1. **Redis Core**: The foundational in-memory database providing fast data structures and primitives.

2. **RediSearch**: A full-text search and secondary index module that allows users to index, query, and perform full-text search on their Redis datasets in a highly scalable and efficient way.

3. **RedisGraph**: A graph database module that uses the property graph model to represent and store data. It supports the Cypher query language for expressing complex graph queries.

4. **RedisTimeSeries**: A module that provides time-series data structure support, allowing for the efficient ingestion, querying, and storage of time-series data within Redis.

5. **RedisJSON**: A module that implements JSON as a native data type, enabling users to store, update, and fetch JSON values from Redis.

6. **RedisBloom**: A probabilistic data structures module that provides scalable Bloom and Cuckoo filters, useful for membership and existence checks with a predefined error rate.

7. **RedisAI**: A module for serving machine learning models and running AI operations within Redis, supporting popular frameworks like TensorFlow, PyTorch, and ONNX.

These components enhance Redis's capabilities, making it suitable for a wider range of applications beyond its traditional use cases as a key-value store and cache.


## Using Redis Stack

We will be running the stack on docker:


`docker run -d --name redis-stack -p 6379:6379 -p 8001:8001 redis/redis-stack:latest`{{exec}}

Now connect to the Redis Stack, and try out the in build tutorials

{{TRAFFIC_HOST1_8001}}

Be sure to check 'I have read and understood the Terms' to get pass the EULA.




