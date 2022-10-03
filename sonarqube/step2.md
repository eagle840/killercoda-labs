# python project


taken from :

https://flask.palletsprojects.com/en/2.2.x/quickstart/#a-minimal-application

`mkdir myproject && cd myproject`{{exec}}

`pip install flask`{{exec}}

'''python
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"
'''

`flask --app hello run --host=0.0.0.0`{{exec}}

exit with ctrl-c

## analysis with sonar-cube

https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/

add a  sonar-qube config to the python project root


`nano sonar-project.properties`{{exec}}

```
# must be unique in a given SonarQube instance
sonar.projectKey=my:project

# --- optional properties ---

# defaults to project key
#sonar.projectName=My project
# defaults to 'not provided'
#sonar.projectVersion=1.0
 
# Path is relative to the sonar-project.properties file. Defaults to .
#sonar.sources=.
 
# Encoding of the source code. Default is default system encoding
#sonar.sourceEncoding=UTF-8
```

and run the analysis:


sonar-scanner -Dsonar.login=myAuthenticationToken

