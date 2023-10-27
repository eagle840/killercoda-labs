# Hello World! using python



# redisInsight

docker pull redislabs/redisinsight

docker run -v redisinsight:/db -p 8001:8001 redislabs/redisinsight:latest

WIP get error: Are you behind a proxy? If so, please set the RedisInsight environment variables


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

