# ZAP


https://www.zaproxy.org/docs/docker/about/


# with webswing

`docker run -u zap -p 8080:8080 -p 8090:8090 -i ghcr.io/zaproxy/zaproxy:stable zap-webswing.sh`{{execute}}

goto /zap/ url

once open

Tools>options>API  note api key value

- Add address' to define what others can access (localhost only by default)

## Modes

- safe
- protected
- standard
- ATTACK


## WINDOWS

```
##################################
# Tree window # Workspace window #
##################################
#     Information window         #
##################################

```

## Wiki/API

once the proxy is setup, a DNS host ZAP is added  :http://ZAP

ajaxsider => ajax syider
ascan     => active scan
context   => contexts
pscan     => passive scan
spider    => regular spider
reports   => reports

## Setting up SSL

In ZAP  settings> Dynamic SSL save the SSL
In Firesfox   Settings> Privacy $ Security > Certicates > view > import (check thrust websites)
  - set proxy to 127.0.0.1:8080 innc https and SOCKS

## Packaged Scans

|     | spider | AJAX Spider | Passive  | ATTACK |
|-----|--------|-------------|----------|--------|
|Basline| X | X | X |   |
|Full   | X | X | X | X |
|API    |   |   |   | X |

## workflow

Context => spider => ascan => reports

API for status  100 = completed scan

# Access the API from outside of the docker container

https://www.zaproxy.org/docs/docker/about/#accessing-the-api-from-outside-of-the-docker-container

Read and comsume this: https://www.zaproxy.org/docs/docker/about/

`docker ps`{{exec}}

what about docker pull ghcr.io/zaproxy/zaproxy:bare

`docker run -u zap -p 8080:8080 -i zaproxy/zap-stable zap.sh -daemon -port 8080 -host 0.0.0.0 -config api.disablekey=true -config api.addrs.addr.name=.* -config api.addrs.addr.regex=true`{{exec}}


Args for starting ZAP
  -config k=v
  -daemon
  -host
  -port
  -new session # with name
  -session  # start session name

`curl    http://localhost:8080/JSON/core/view/version`{{exec}}


`touch scan_request.json`{{exec}}

`nano scan_request.json`{{exec}}

```
{
  "url": "http://example.com",
  "context": "Default Context",
  "recurse": "true",
  "inScopeOnly": "false"
}
```
need to add context: "Default Context"

WIP: list contexts

Documentation? https://www.zaproxy.org/docs/api/#api-catalogue

for the following scan: https://www.zaproxy.org/docs/api/?shell#ascanactionscan

`curl -X POST http://localhost:8080/JSON/ascan/action/scan/ -d @scan_request.json -H "Content-Type: application/json"`{{exec}}

## Addons

Also know as market place

www.zaproxy.org/addons
