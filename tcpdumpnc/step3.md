### wireshark

Lets install wireshark for console (tshark)
`apt-get update -y`{{ execute }}


`apt-get install tshark -y`{{ execute }}
Enter yes when prompted.


`which tshark`{{ execute }}
/usr/bin/tshark

Lets capture some packets (stop after 30s ctrl-c) to file tcpdump.pcap

`tcpdump -i ens3 -c 5 -w tcpdump.pcap`{{ execute }}

And take a look at that file through tshark
`tshark -r tcpdump.pcap`{{ execute }}

And finally we'll all done with this lab. Feel free to play around, the lab is available for 1hr and nothing is saved. 

As usually Google is your friend, to find some examples to play around with.



