# python project


taken from :

https://flask.palletsprojects.com/en/2.2.x/quickstart/#a-minimal-application

`cd ~`{{exec}}

`mkdir myproject && cd myproject`{{exec}}

`pip install flask`{{exec}}

`nano hello.py`{{exec}}

```
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"
```{{copy}}

confirm the app is working

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
```{{copy}}

WIP `sonar.profile=<quality rules profile>`
can be added to the above profile to assoisat the scanner run with  a quality rules profile

for more info on this project config file: https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/


and run the analysis using the code snippet from step 1. Once complete the page will refresh

example code snippet:


```
sonar-scanner \
  -Dsonar.projectKey=pyproject \
  -Dsonar.sources=. \
  -Dsonar.host.url=https://93cdfbdc-1290-4e26-80e3-3d9f821c30d7-10-244-5-186-9000.spch.r.killercoda.com \
  -Dsonar.login=sqp_ab68ca7ea0b4495b4aa5fb8e1703aacb73b4c1d8
```

Once the first run is complete the web gui will refresh, go into the new project and you'll see that it was passed, and has two tabs: 'New Code' And 'Overall code'.

Then you first run the scanner on a project it will analysis the whole project, but subsusqute runs will only anaylsys the new code.

Run the scanner again, and you'll see the 'new code' tab populated, all with a passing score

lets add some code that will generated an 'code smell'

add 'pass' to the end of the python file

`echo 'pass' >> hello.py`{{exec}}

and re-run the scanner, and you'll see that it fails due to the code-smell
