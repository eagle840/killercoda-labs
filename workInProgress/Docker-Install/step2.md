# ZAP


https://www.zaproxy.org/docs/docker/about/


# Access the API from outside of the docker container

`https://www.zaproxy.org/docs/docker/about/#accessing-the-api-from-outside-of-the-docker-container`{{exec}}

`docker ps`{{exec}}


`docker run -u zap -p 8080:8080 -i zaproxy/zap-stable zap.sh -daemon -port 8080 -host 0.0.0.0 -config api.disablekey=true -config api.addrs.addr.name=.* -config api.addrs.addr.regex=true`{{exec}}

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

`curl -X POST http://localhost:8080/JSON/ascan/action/scan/ -d @scan_request.json -H "Content-Type: application/json"`{{exec}}
