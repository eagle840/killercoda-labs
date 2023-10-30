
# Web


Following https://docs.konghq.com/gateway/3.4.x/get-started/services-and-routes/
## create service

`curl -i -s -X POST http://localhost:8001/services --data name=example_service --data url='http://mockbin.org'`{{exec}}


## Viewing service configuration

`curl -X GET http://localhost:8001/services/example_service | jq`{{exec}}

## Updating services

`curl --request PATCH --url localhost:8001/services/example_service --data retries=6 | jq `{{exec}}

## List Services

`curl -X GET http://localhost:8001/services | jq`{{exec}}


2. To add a service, you can send a POST request to the `/services` endpoint. Here is an example of how to do this with curl:

```
curl -i -X POST \
  --url http://localhost:8001/services/ \
  --data 'name=my-service' \
  --data 'url=http://localhost:8080'
```{{exec}}

In this example, `my-service` is the name of the service and `http://localhost:3000` is the URL where the service is running.

3. After running this command, you should receive a response from the Kong Admin API confirming that the service has been added.

4. Now, you can add routes to this service. To add a route, you can send a POST request to the `/services/my-service/routes` endpoint. Here is an example:

```
curl -i -X POST \
  --url http://localhost:8001/services/my-service/routes \
  --data 'paths[]=/my-service'
```{{exec}}

In this example, `/my-service` is the path of the route.

5. After running this command, you should receive a response from the Kong Admin API confirming that the route has been added.

Now, any requests to `http://localhost:8000/my-service` will be forwarded to `http://localhost:3000`.

Please replace `localhost` and `my-service` with your actual service details.

{{TRAFFIC_HOST1_8000/my_service/swagger/index.html}}

## API 

ADD service ad route for API

## add service

```
curl -i -X POST \
  --url http://localhost:8001/services/ \
  --data 'name=my-api' \
  --data 'url=http://localhost:8088'
```{{exec}}

## add route

```
curl -i -X POST \
  --url http://localhost:8001/services/my-api/routes \
  --data 'paths[]=/my-api'
```{{exec}}