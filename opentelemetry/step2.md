# Hello World!


## Metrics

start prometheus

add to the prometheus config:

```yaml
  - job_name: "opentelemetry"
    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.
    static_configs:
      - targets: ["localhost:9464"]
```

new directory

WIP `cd .. && mkdir open_metrics`{{copy}}

`npm -i @opentelemetry/metrics`{{exec}}


`nano monitoring.js`{{exec}}


```
'use strict'; 

const { MeterProvider } = require('@opentelemetry/metrics'); 

const meter = new Meterprovider() .getMeter('your-meter-name');

const requestCount = meter.createCounter("requests" , {
  description: "Count all incoming requests" 
});

const boundlnstruments = new Map(); 

module. exports. countAllRequests = 
    return (req. res, next) { 
        if ( path)) { 
            const labels = { route: req. path 
            const boundCounter = requestCount.bind(labels); 
            boundlnstruments. Set( req. path, boundCounter) ; 
        boundlnstruments. get (req. path) . add(l) ; 
        next(); 
    };
};
```{{copy}}

in apps.js
at line 3


## Adding Grafana WIP in own step!

`docker run --name grafana --net host -p 3000:3000 grafana/grafana-oss`{{exec}}



connect to port 3000

{{TRAFFIC_HOST1_3000}}

can use: un & pw: admin

You can skip the password reset.

go into datasources and add zipkin, with HTTP:URL:

`http://localhost:9411`

save and test



