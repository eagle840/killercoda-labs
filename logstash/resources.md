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