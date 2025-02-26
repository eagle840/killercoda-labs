# My first function app


## Start a new function app

Function vs Function App, the app is what holds the functions.

### Create the 'Function App'

`func init MyProjFolder --worker-runtime python --model V2`{{exec}}

WIP appears this creats code in the folder MyProjFolder



select 'python' and 'anonymous'

`tree`{{exec}}

`cd MyProjFolder`{{exec}}

`cat function_app.py`{{exec}}

The app only contains a bare template - creates only an instance of the FunctionApp class

### Create the 'Function'

Lets add a 'function'

`func new --template "Http Trigger" --name http_trigger1 --authlevel "anonymous"`{{exec}}

Note that the name is used in the url `/api/<name>`

select 'python' and 'anonymous'

See how the code has been added to the app:

`cat function_app.py`{{exec}}

we'll start the app in verbose mode:

`func start --verbose`{{exec}}

Note the returned url in yellow

WIP `Reading host configuration file '/root/cleanproject/host.json'`

WIP it looks like the run function auto reloads on code change.

**open a new tab**


### GET

`curl http://localhost:7071/api/http_trigger1?name=john`{{exec}}


### POST
```
curl -X POST \
  http://localhost:7071/api/http_trigger1 \
  -H 'Content-Type: application/json' \
  -d '{"name": "nick"}'
```{{exec}}

# Add a second function

Stop the func app

Make sure you're still in  the MyProjFolder

`func new --template "Timer Trigger" --name myTimerFunc`{{exec}}

- select python
- enter for the schedule:  `0 */1 * * * *` # every minute

And check the editor for the new updated code.

`cat function_app.py`{{exec}}


`func start --verbose`{{exec}}

Note the logs showing the app first every minute.
