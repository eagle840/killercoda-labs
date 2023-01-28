Lets use faker to send logs

https://github.com/thombashi/elasticsearch-faker

`pip install elasticsearch-faker`{{exec}}


## using logstash to send a csv


```
input {
    file {
        path => "path"
        start_position => "beginning"
        sincedb_path = > "/dev/null" # windows "NULL"
    }
}
filter {
    csv {
        separator => ","
        columns => ["col1",col2"]
    }
}
output {
    elasticsearch {
        hosts => "http://localhost:9200"
        index => "new_index_name"
    }
}
```

then add an index pattern into kibana

## BEATS

lets check the Elastic version

`curl http://localhost:9200`{{exec}}

and install the same Beats version:

WIP move to step 1 the key update


`wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg`{{exec}}

`sudo apt-get install apt-transport-https`{{exec}}

`echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list`{{exec}}

`sudo apt-get update`{{exec}}

### main cmds/setting

<beatcmd> test config # to test the yml config
<beatcmd> test output # to test connection to ES
<beatcmd> setup # to setup dashboard etc in es/kibana stack 

## metricbeat


`apt install metricbeat=7.17.4`{{copy}}

WIP update docker to the same

WIP `metricbeat setup`{{copy}}


`sudo apt-get install metricbeat=7.17.4`{{copy}}

`curl http://localhost:9200`{{exec}}

`sudo systemctl enable metricbeat`{{exec}}

`sudo update-rc.d metricbeat defaults 95 10`{{exec}}

create some load:

`apt install stress`{{exec}}

`nproc`{{exec}}

`stress --cpu 1 --timeout 120`{{exec}}

`stree --vm 5 --timeout 180`{{exec}}

## Debugging

IN the output section of any of the beat yml files,  comment out all connection to ES servers/cloud, and set the output:

```
output.file:
   path: "."
   filename: "events.log"
```

you can now start a beat, and tail that log to troubleshoot