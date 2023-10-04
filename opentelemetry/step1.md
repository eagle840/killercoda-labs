
# Initial Setup

https://opentelemetry.io/docs/instrumentation/js/getting-started/nodejs/s


 `sudo apt-get update`{{exec}}

`git clone https://github.com/kubowania/opentelemetry-tracing.git`{{exec}}

`apt install -y nodejs npm`{{exec}}

`cd opentelemetry-tracing/`{{exec}}

we'll be using the zipkin tracing system: https://zipkin.io/ 

`docker run -d --rm -p 9411:9411 openzipkin/zipkin`{{exec}}

confirm zipkin is running:

{{TRAFFIC_HOST1_9411}}

Lets install the required node packages

`npm i`{{exec}}

Lets review the code:

`cat tracing.js`{{exec}}

WIP: link to opentelemtry for nodejs

https://opentelemetry.io/docs/instrumentation/js/getting-started/nodejs/

Review the app, a simple http responce program

notice we installed a 'core' and an 'exporter' for zipkin

`cat app.js`{{exec}}

`node -r ./tracing.js app.js`{{exec}}

'-r ./tracing.js' will proprogate traces over http

terminal 2
----------

`curl -v localhost:8080`{{exec}}

`curl -v localhost:8080/date`{{exec}}

## review log

return to the zipkin page and press 'query'

review results

other
-----

`cat ~/opentelemetry-tracing/tracing.js`{{exec}}


note: const { ZipkinExporter } = require("@opentelemetry/exporter-zipkin");
