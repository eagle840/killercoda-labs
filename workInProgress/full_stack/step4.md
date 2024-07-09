STep 4

## add proxy

Lets now connect the React app to the API.

In the first terminal tab

update **vite.config.js in** PizzaClient

`cd ~`{{exec}}

`cd PizzaClient/`{{exec}}

in vite.config.js CHANGE port to 5000 on line 12


`npm run dev`{{exec}}

{{TRAFFIC_HOST1_3000}}

if you get an error 'connect ECONNREFUSED 127.0.0.1:5000' make sure the api server in running in the other terminal tab.

Add a pizza to the menu, and confirm it's showing up it the 'GET /Pizzas'

{{TRAFFIC_HOST1_5000}}/swagger
