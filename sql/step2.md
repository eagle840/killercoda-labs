# Save And Restore - Manual

In this step we'll manually backup  the databases, remove them and then restore, and then setup cron to do automatic backups.

Lets create a backup folder on the local host

`mkdir backups`{{execute}}

and start mysql in docker, using the data/ volume for the database and backups/ for the backup.

Since the sql data is still in the data volume from the last step, we'll be using that as the db. 

`docker run --name some-mysql -v /root/data:/var/lib/mysql -v /root/backups:/backups -e MYSQL_ROOT_PASSWORD=1234 -d mysql:8.0.2`{{execute}}


### backup one db


we'll use the mysqldump command to generate a text backup file:

Lets connect to the docker container and use the mysqldump to backup the database test1:

`docker exec -it some-mysql bash`{{execute}}

`mysqldump --add-drop-table --password=1234 --databases test1  > /backups/$(/bin/date +\%Y-%m-\%d).sql.bak`{{execute}}

(note: using this script will overwrite the backup if run again over the same day)
(--add-drop-table: will make the restore remove the table before restoring it)

### backup all

`mysqldump --all-databases --password=1234  > /backups/fulldump.sql`{{execute}}

and check we have the backup files:

`ls backups`{{execute}}

Lets go ahead and destroy the container   

`exit`{{execute}}   


`docker exec -it  some-mysql mysql -uroot -p1234 -e "drop database test1"`{{execute}} 

`docker stop some-mysql`{{execute}}

`docker rm some-mysql `{{execute}}

Lets remove the data folder

`rm -r data/`{{execute}}

## Restore

Startup the docker container:   

`docker run --name some-mysql -v /root/data:/var/lib/mysql -v /root/backups:/backups -e MYSQL_ROOT_PASSWORD=1234 -d mysql:8.0.2`{{execute}}

and connect

`docker exec -it some-mysql bash`{{execute}}   

and run the restore:

`mysql -uroot -p1234 < /backups/fulldump.sql`{{execute}}

and make sure the data is back in place.

`mysql -uroot -p1234 -e "SHOW databases; USE test1; SHOW tables; SELECT * FROM Persons;"`{{execute}}

and exit the container:

`exit`{{execute}}


# Save And Restore - Auto 

Lets create a command that can be run in a script.

`cd backups`{{execute}}

`nano backup.sh`{{execute}}   

copy & paste the following  into it and save 

`docker exec -it some-mysql -- mysqldump --add-drop-table --password=1234 --databases test1  > backups/$(/bin/date +\%Y-%m-\%d-\%H-\%M).sql.bak`

(ctl-o to save, ctl-x to exit)

then change the execute mode

`chmod 0777 backup.sh`{{execute}}   

`cd ..`{{execute}}    

Lets test it 

`./backups/backup.sh`{{execute}}   
and confirm that new file is written   
`ls backups`{{execute}}   

## schedule it with crontab (in progress)

In this part we'll setup a cron job to automatically run backups

Lets first get a time check:`date`{{execute}}   

For me it was 13:50, 

lets edit the crontab file and add a couple of minutes to the time:

`crontab -e`{{execute}}

`55 13 * * *  /root/backups/backup.sh`   

55: min
13: hr
'* * * : every day'

Save and exit, and wait until the time is up.   

Lets check the folder to confirm.

`ls backups`{{execute}}


## remove the container

`docker stop some-mysql`{{execute}}

`docker rm some-mysql `{{execute}}

