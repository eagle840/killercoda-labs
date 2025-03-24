
# Docker Install


## System update

`sudo apt update`{{exec}}

`apt install jq -y`{{exec}}

## Docker version check

`docker version`{{exec}}

`docker-compose version`{{exec}}

`docker compose version`{{exec}}

Lets pull down the images we'll use.

## Zap on Docker

https://www.zaproxy.org/docs/docker/

`docker run -u zap -it  zaproxy/zap-stable zap.sh -help`{{exec}}

WIP see error below before running

```
mkdir -p $(pwd)/output
chmod -R 777 $(pwd)/output
```{{exec}}

`docker run -u zap -it -v $(pwd):/output  zaproxy/zap-stable zap.sh -daemon -quickurl http://www.example.com -quickprogress -quickout report1.html`{{copy}}

`docker run -u zap -it -v $(pwd):/output zaproxy/zap-stable zap.sh -daemon -quickurl http://www.example.com -quickprogress -quickout /output/report1.html`{{exec}}


```
Attack complete
Writing results to /zap/report1.html
The directory of given '-quickout' file is not writable:
/zap/report1.html
```

try -u root

test to comfirm

`docker run -u zap -it -v $(pwd)/output:/output zaproxy/zap-stable touch /output/testfile.txt`{{copy}}

## Lets start juice shop

`docker run --rm -p 3000:3000 bkimminich/juice-shop`{{exec}}

Can can view juice-shop here: {{TRAFFIC_HOST1_3000}}

## baseline scan

https://www.zaproxy.org/docs/docker/baseline-scan/

`docker run -v $(pwd):/zap/wrk/:rw -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py -t https://www.example.com -g gen.conf -r testreport.html`{{exec}}

`docker run -u zap -it -v $(pwd):/output zaproxy/zap-stable zap.sh -daemon -quickurl {{TRAFFIC_HOST1_3000}} -quickprogress -quickout /output/report1.html`{{exec}}


## API scan

https://www.zaproxy.org/docs/docker/api-scan/

against juice shop?


## Juice shop


Lets start juice shop

`docker run --rm -p 3000:3000 bkimminich/juice-shop`{{exec}}

Can can view juice-shop here: {{TRAFFIC_HOST1_3000}}

WIP Also at https://juice-shop.herokuapp.com/

and confirm it's up with a apu call


`curl http://localhost:3000/rest/products/search?q=Apple`{{exec}}

`curl http://localhost:3000/rest/products/search?q=Apple | jq`{{exec}}
