# mock api


new terminal

add db.json

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


npx json-server --watch db.json --port 5100




