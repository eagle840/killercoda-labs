# mock api

Using the npm built in api server [json-server](https://www.npmjs.com/package/json-server)

Start a new terminal

`touch db.json`{{exec}}

```
{
  "pizzas": [
      { "id": 1, "name": "Margherita", "description": "Tomato sauce, mozzarella, and basil" },
      { "id": 2, "name": "Pepperoni", "description": "Tomato sauce, mozzarella, and pepperoni" },
      { "id": 3, "name": "Hawaiian", "description": "Tomato sauce, mozzarella, ham, and pineapple" }
  ]
}
```

then run the program json-server


`npx json-server --watch db.json --port 5100`{{exec}}

add extention for curk to vsc

curl http://localhost:5100/pizzas

using the code on https://learn.microsoft.com/en-us/training/modules/build-web-api-minimal-spa/5-exercise-create-api

add the mocked api
