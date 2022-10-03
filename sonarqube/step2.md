#  setup git server

https://www.linux.com/training-tutorials/how-run-your-own-git-server/

Better still, create it in a docker container

https://hub.docker.com/r/jkarlos/git-server-docker/
#

`docker run -d -p 2222:22 -v ~/git-server/keys:/git-server/keys -v ~/git-server/repos:/git-server/repos jkarlos/git-server-docker`{{exxecute}}

confirm it's running:
`docker ps`{{execute}}


----- with docker compose

##  https://linuxhint.com/setup_git_http_server_docker/

`docker-compose version`{{execute}}

`mkdir -p ~/docker/gitserver/{repos,etc}`{{execute}}

`cd ~/docker/gitserver`{{execute}}

`nano gitserver.Dockerfile`{{execute}}

```
FROM ubuntu:18.04
RUN apt update 2>/dev/null
RUN apt install -y git apache2 apache2-utils 2>/dev/null
RUN a2enmod env cgi alias rewrite
RUN mkdir /var/www/git
RUN chown -Rfv www-data:www-data /var/www/git
COPY ./etc/git.conf /etc/apache2/sites-available/git.conf
COPY ./etc/git-create-repo.sh /usr/bin/mkrepo
RUN chmod +x /usr/bin/mkrepo
RUN a2dissite 000-default.conf
RUN a2ensite git.conf
RUN git config --system http.receivepack true
RUN git config --system http.uploadpack true
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
CMD /usr/sbin/apache2ctl -D FOREGROUND
EXPOSE 80/tcp
```

`nano etc/git.conf`{{execute}}

```
<VirtualHost *:80>
ServerAdmin webmaster@localhost
 
SetEnv GIT_PROJECT_ROOT /var/www/git
SetEnv GIT_HTTP_EXPORT_ALL
ScriptAlias / /usr/lib/git-core/git-http-backend/
 
Alias / /var/www/git
 
<Directory /usr/lib/git-core>
Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
AllowOverride None
Require all granted
</Directory>
 
DocumentRoot /var/www/html
 
<Directory /var/www>
Options Indexes FollowSymLinks MultiViews
AllowOverride None
Require all granted
</Directory>
ErrorLog ${APACHE_LOG_DIR}/error.log
LogLevel warn
CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

`nano etc/git-create-repo.sh`{{execute}}

```
#!/bin/bash
 
GIT_DIR="/var/www/git"
REPO_NAME=$1
 
mkdir -p "${GIT_DIR}/${REPO_NAME}.git"
cd "${GIT_DIR}/${REPO_NAME}.git"
 
git init --bare &> /dev/null
touch git-daemon-export-ok
cp hooks/post-update.sample hooks/post-update
git update-server-info
chown -Rf www-data:www-data "${GIT_DIR}/${REPO_NAME}.git"
echo "Git repository '${REPO_NAME}' created in ${GIT_DIR}/${REPO_NAME}.git"
```

`nano docker-compose.yaml`{{execute}}

```
version: "3.7"
services:
  git-server:
    build:
      dockerfile: gitserver.Dockerfile
      context: .
    restart: always
    ports:
      - "8080:80"
    volumes:
      - ./repos:/var/www/git
      
```

`docker-compose build`{{execute}}

`docker-compose up -d`{{execute}}

`docker-compose ps`{{execute}}



To create a new Git repository test (let’s say) on the Git HTTP server container, run the following command:

`docker-compose exec git-server mkrepo test`{{execute}}

