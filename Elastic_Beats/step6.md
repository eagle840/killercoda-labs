# Packetbeat

[Documentation](https://www.elastic.co/guide/en/beats/packetbeat/7.17/packetbeat-overview.html)

`apt install packetbeat=7.17.4`{{exec}}

`packetbeat -h`{{exec}}

`packetbeat test output`{{exec}} to confirm that it can connect to ElasticSearch

`packetbeat setup -e`{{exec}}  to setup dashboard and index's

`packetbeat devices`{{exec}}  to list out network adaptors

We'll over-ride the config and tell packetbeat to only collect packets on the default nic

`packetbeat run --E packetbeat.interfaces.device: enp1s0`{{exec}}

You can now check ES GUI dashboard for packet beat.

## wireshatk & packetbeat

Capture a session with Wireshark, and save it as a pcap file

eun packetbeat -i <filename>

and packetbeat will start sending it to  kibana.