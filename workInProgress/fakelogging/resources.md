start a multinode ES cluster, see https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#docker-compose-file


logstash conf eg: https://www.elastic.co/guide/en/logstash/current/config-examples.html


https://www.youtube.com/watch?v=Mma7HKt-mk8&list=PLECxNUHStsl9pWSPKMATMx9lbbHbTY0Wi&index=5
^ grok pattern

https://raw.githubusercontent.com/edgoad/syslog-generator/master/syslogGen1.sh

ES8 on docker:

https://github.com/deviantony/docker-elk
clone and bring it up
user: elastic
password: changeme



https://github.com/thombashi/elasticsearch-faker

http://media.sundog-soft.com/es/ml-latest-small.zip # 100k ratings
                            /es8/movies.json  # _bulk insert

                            grok

lookup
%{DATA:class}
%{GREEDY:message}


cjslack/grok-debugger/public/patterns/rails

manpages.org/grok

https://logz.io/blog/logstash-grok/

logstash-plugins/logstash-patterns-core/patterns/legacy




# grok debugger

unstructured log and event data into structured data

## pattern matching

https://www.elastic.co/guide/en/logstash/current/plugins-filters-grok.html

%{SYNTAX:SEMANTIC}   # SYNTAX is the pattern, SEMANTIC is the 'key' 

SEMANTIC by default is a string, if you want a number, prefix it with 'num:'

while regx has
```
IPV4 (?<![0-9])(?:(?:25[0-5]|2[0-4][0-9]|[0-1]?[0-9]{1,2})[.](?:25[0-5]|2[0-4][0-9]|[0-1]?[0-9]{1,2})[.](?:25[0-5]|2[0-4][0-9]|[0-1]?[0-9]{1,2})[.](?:25[0-5]|2[0-4][0-9]|[0-1]?[0-9]{1,2}))(?![0-9])
```

with grok you can use a shortcut of %{IPv4: ClientIP}

for a regx patern, use     
```
(?<custom_field>custom pattern)
```
where Custom_field will be the K, and the 'custom pattern' will be a  regex expression, its evalution being the value
## example logs here


## grok example code here


>> press simulate in - kibana devtools , tab Grok debugger

 goto:

https://grokdebug.herokuapp.com/  and select the discover tab

or try https://grokdebugger.com/  # left hand side is shortcuts added to autocomplete - besure to set the 'grok=patterns'

https://grokconstructor.appspot.com/

start with the pattern '%{GREEDYDATA:message}' and add the additional patterns before it

In the kibana ui, goto discover and copy the msg text 

past the msg into the fieldss


- pull example log for kibana>discover  and paste into grok debug
- can also use logstash config filter section

download 

https://www.kaggle.com/rmisra/news-category-dataset

Open the kibana homepage, and upload the data with drag and drop

Kibana will now show an over view of the data

scroll down and 'import'

Give your data an index name 'news_headlines'

## Precision vs Recall