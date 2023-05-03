# MetricBeats

https://www.elastic.co/guide/en/beats/metricbeat/7.17/metricbeat-overview.html

This shipper allows you to directly ship the system metrics to ES

just install

`apt install metricbeat=7.17.4`{{exec}}

`metricbeat -h`{{exec}}

Review the yml config

`cat /etc/metricbeat/metricbeat.yml`{{exec}}

and list which modules are installed

`ls /etc/metricbeat/modules.d`{{exec}}

Note that the system module is enabled (not disabled)

it is already set for the localhost (system)

Lets setup metricbeat for use:

`metricbeat test config`{{exec}}

`metricbeat test output`{{exec}}

`metricbeat setup`{{exec}}  

Setup will take a few minutes.

Now enable metricbeats as a service to start piping metrics to ES:

`sudo systemctl enable metricbeat.service`{{exec}}

`sudo systemctl start metricbeat.service`{{exec}}

You can now check the ES GUI for the new indices, index-patterns and dashboards.

Navigate to Metrics in the Oservability Section, and review the metrics.

You can also config metricbeat to run with other systems:

`metricbeat modules list`{{exec}}

`metricbeat modules enable <moduleName>`

Note that you have to run 'metricbeat setup' and restart the service, including other beats tools.

Lets review the logs for this tool:

`cat /var/log/metricbeat/metricbeat`{{exec}}

The reference file is included to give examples, and not intended to be used:
`cat  /etc/metricbeat/metricbeat.reference.yml`{{exec}}

For a extensive tutorial on metricbeat see https://www.youtube.com/playlist?list=PL_mJOmq4zsHYTSN_tUTWJVuLMcwA0DRS3

