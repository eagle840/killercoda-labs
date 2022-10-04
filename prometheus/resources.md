
https://killercoda.com/spcloud/course/basics/creating-dashboards-with-grafana



mkdir data
   13  chmod -R 777 data
   14  cp prometheus.yml ./data/prometheus.yml
   15  docker run -d --net=host     -v /root/data:/etc/prometheus/         --name prometheus-server     prom/prometheus
   16  docker ps