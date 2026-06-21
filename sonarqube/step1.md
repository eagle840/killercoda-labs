# setup


# NOTE


This fixes a docker problem closing down the sonarcube container:
`sysctl -w vm.max_map_count=262144`{{execute}}

##  Start Sonarcube

Git repo: https://github.com/SonarSource/docker-sonarqube/blob/master/example-compose-files/README.md



`cd ~`{{execute}}

`git clone https://github.com/SonarSource/docker-sonarqube.git`{{execute}}

`cd docker-sonarqube/example-compose-files/sq-with-postgres/`{{execute}}

`docker-compose up -d`{{exec}}

# Check if SonarQube is up

It will take a few minutes for SonarQube to startup. Let's run a loop that waits for the service to become fully healthy:

```bash
until curl -s http://localhost:9000/api/system/health | grep -q '"status":"GREEN"\|"status":"YELLOW"'; do
  echo "SonarQube is starting up... waiting 10 seconds"
  sleep 10
done
echo "SonarQube is UP and healthy!"
```{{exec}}

To confirm both containers (SonarQube and PostgreSQL) are up and running, you can run:

`docker-compose ps`{{execute}}

Connect to the SonarQube web page using the link below:

{{TRAFFIC_HOST1_9000}}

The default credentials are:
- Username: `admin`
- Password: `admin`

When prompted, update the password to: `Admin123456789!`{{copy}}


# Create a new local Sonarqube project

1. Under 'How do you want to create your project?', select **Manually**.
2. Set both the Project Name and Project Key to: `pyproject`.
3. Under 'How do you want to analyze your repository?', select **Locally**.
4. Generate the token, and copy it down. You will use it in Step 2.
5. Select **Python** as the language and **Linux** as the OS.

# Download and install SonarQube CLI

Let's install the standard `sonar-scanner` command-line utility:

`cd ~`{{exec}}

`wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-8.1.0.6389-linux-x64.zip`{{exec}}

`unzip sonar-scanner-cli-8.1.0.6389-linux-x64.zip`{{exec}}

`ln -sf /root/sonar-scanner-8.1.0.6389-linux-x64/bin/sonar-scanner /usr/local/bin/sonar-scanner`{{exec}}

Verify the installation:

`sonar-scanner -v`{{exec}}

Now, configure the scanner properties automatically to point to our local SonarQube server:

```bash
cat << 'EOF' > /root/sonar-scanner-8.1.0.6389-linux-x64/conf/sonar-scanner.properties
sonar.host.url=http://localhost:9000
sonar.sourceEncoding=UTF-8
EOF
```{{exec}}


