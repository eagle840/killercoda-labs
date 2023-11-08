

--- uni --

basic

keys & expriration
- upto 512MB in size
- logical databases, start at [0], cluster only has [0]
- case senistive
- customer:1000  is considered the key, you'd put a space and then the value
>get

>scan slot [MATCH pattern] [COUNT count]


| keys | scan |
|------|------|
| Blocks until complete |  iterates using a cursor |
| Never use in production | returns a reference |
|Usful for debugging | may return 0 or more keys per cell |
| | safe for production |

strings

hashes (K;v)

## sets

Lists


# Using RedisInsight

https://github.com/RedisInsight/RedisInsight

https://redis.io/resources/tools/

# redisInsight

WIP try https://docs.redis.com/latest/ri/using-redisinsight/proxy/#trusted-origins

`docker pull redislabs/redisinsight`{{exec}}

`docker run -v redisinsight:/db -p 8001:8001 redislabs/redisinsight:latest`{{exec}}

{{TRAFFIC_HOST1_80}}

WIP get error: Are you behind a proxy? If so, please set the RedisInsight environment variables

the following works, leave username blank

` docker run -d --name redis-stack -p 6379:6379 -p 8001:8001 -e REDIS_ARGS="--requirepass mypassword" redis/redis-stack:latest`{{exec}}

`docker exec -it redis-stack redis-cli -a mypassword`{{exec}}

https://hub.docker.com/r/redis/redis-stack

WIP troubleshoot
`docker history    redis/redis-stack`{{EXEC}}
