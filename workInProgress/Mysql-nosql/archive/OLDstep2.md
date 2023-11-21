# Save And Restore

Lets start with a container with a data and backup folder

`mkdir backups`{{execute}}

`docker run --name some-mysql -v /root/data:/var/lib/mysql -v /root/backups:/backups -e MYSQL_ROOT_PASSWORD=1234 -d mysql`{{execute}}

**WIP**  create a db in mysql

so we don't have to be prompted everytime we run a backup, we'll create a .my.cnf file with the un and pw

store mysql root password in /root/.my.cnf   (chmod 600 .my.cnf)  
**WIP*** needs to go into container  
copy and paste into  .my.conf  

'''yaml
[client]
user=root
password=1234
'''
and allow only root  
`chmod 600 .my.cnf`{{execute}}


### backup one db


we'll use the mysqldump command to generate a txt backup file:


**WIP** error on:  
`mysqldump --add-drop-table --databases test  > /backups/$(/bin/date +\%Y-%m-\%d).sql.bak`{{execute}}

* pw pulled from .my.cnf

### backup all

`mysqldump --all-databases --all-routines > ~/backups/allbds/fulldump.sql`{{execute}}

### delete the db

`docker exec -it  some-mysql mysql -uroot -e "drop database test1"`{{execute}} 

## Restore

`mysql -uroot  [database name] < <backupname>.sql`

**WIP** correctly mount the volume for restore

`mysql -uroot -p < fulldump.sql`

### schedule it with crontab

`nano /etc/crontab`

(8:06)


## Reset password

check mysql docs to add section

## remove the container

`docker stop some-mysql`{{execute}}

`docker rm some-mysql `{{execute}}

