# Using RedisInsight

https://github.com/RedisInsight/RedisInsight

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




# benchmark

in a new tab, red htop

in this tab


https://redis.io/docs/management/optimization/benchmarks/



`redis-benchmark -q -n 100000`{{exec}}

`redis-benchmark -h`

-n number of commands
-d datasize 
-q quiet
-c parrellel coonections (default 50)


`redis-benchmark -n 1000`{{exec}}

## optimize

https://redis.io/docs/management/optimization/

## troubleshoot

https://redis.io/docs/management/troubleshooting/

