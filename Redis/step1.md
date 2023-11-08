# Redis Server

## Redis Server Overview

Redis Server is the core component of Redis, an open-source, in-memory data structure store used as a database, cache, and message broker. It provides fundamental data structures such as strings, hashes, lists, sets, and sorted sets with range queries, and supports various features like transactions, pub/sub, and Lua scripting.


## Install Redis locally 

`sudo apt update`{{exec}}


following https://redis.io/docs/install/install-redis/install-redis-on-linux/

`sudo apt install lsb-release curl gpg -y `{{exec}}

`curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg`{{exec}}

`echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list`{{exec}}

`sudo apt-get update`{{exec}}

`sudo apt-get install redis -y `{{exec}}

Redis should now be up and running

start redis client

`redis-cli`{{exec}}

## Test Redis

the ping command will return pong, it the server is up and running

`ping`{{exec}}

And find out more about this server.

`INFO`{{exec}}

## Basic key commands
    
`set mykey hello`{{exec}}

`get mykey`{{exec}}

scan slot [MATCH pattern] [COUNT count]

`scan 0 MATCH he*`{{exec}}

1st value returned is a new slot valus to use in the next scan command

`ping`{{exec}}

`INFO`{{exec}}

ctrl=-c to exit

more on datatypes: https://redis.io/docs/data-types/

## benchmark

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

