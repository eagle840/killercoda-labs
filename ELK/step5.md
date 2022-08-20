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