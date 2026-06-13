# Git install

some of these might be wrong/duplicate

`cd ~`{{exec}}

# short version

`apt-get update`{{execute}}

`sudo apt update`{{execute}}

`sudo adduser git`{{execute}}


seond set GIT folder

```
cd ~
sudo -u git mkdir /home/git/myproject.git
sudo -u git git init --bare /home/git/myproject.git
sudo chown -R git:git /home/git/myproject.git
git clone git@localhost:/home/git/myproject.git
```{{exec}}

thrid set

```
cd myproject
echo "# My Project" >> README.md
git add README.md
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
git commit -m "Initial commit"
git push origin master
```{{exec}}

# long version



`sudo adduser git`{{execute}}

`sudo -u git mkdir /home/git/myproject.git`{{execute}}

`sudo -u git git init --bare /home/git/myproject.git`{{execute}}

`sudo chown -R git:git /home/git/myproject.git`{{execute}}

`git clone git@localhost:/home/git/myproject.git`{{execute}}

`cd myproject`{{execute}}

`echo "# My Project" >> README.md`{{execute}}

`git add README.md`{{execute}}

`git config --global user.email "you@example.com"`{{execute}}

`git config --global user.name "Your Name"`{{execute}}

`git commit -m "Initial commit"`{{execute}}

`git push origin master`{{execute}}




# python project


taken from :

https://flask.palletsprojects.com/en/2.2.x/quickstart/#a-minimal-application

`cd ~`{{exec}}

`cd myproject`{{exec}}

`sudo apt install -y python3-venv`{{exec}}

`python3 -m venv venv`{{exec}}

`source venv/bin/activate`{{exec}}


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


In the SonarQube web page follow instruction,

Show ask you to install `pip install pysonar`  when run a multi-line pysonar command

`pysonar -h`{{exec}}

This should take about 5 mins to run

### other:

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

Suggested you open a new tab and run `htop`{{exec}} to see how heavy your lab session is being run.

example code snippet (use the code copied form the SonarQube page!):

Expect 1st run to be under 1 min

```
sonar-scanner \
  -Dsonar.projectKey=pyproject \
  -Dsonar.sources=. \
  -Dsonar.host.url={{TRAFFIC_HOST1_9000}} \
  -Dsonar.login=sqp_ab68ca7ea0b4495b4aa5fb8e1703aacb73b4c1d8
```

Once the first run is complete the web gui will refresh, go into the new project and you'll see that it was passed, and has two tabs: 'New Code' And 'Overall code'.

Then you first run the scanner on a project it will analysis the whole project, but subsusqute runs will only anaylsys the new code.

Run the scanner again, and you'll see the 'new code' tab populated, all with a passing score

lets add some code that will generated an 'code smell'

add 'pass' to the end of the python file

`echo 'pass' >> hello.py`{{exec}}

and re-run the scanner, and you'll see that it fails due to the code-smell
