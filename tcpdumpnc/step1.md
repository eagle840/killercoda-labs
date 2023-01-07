# Overview of tcpdump

tip!
try not to use the 'auto execute', but actually type the commands in, you'll retain the information for longer.   

hint:
ctrl-L refreshes the terminal, just like `clear`,
not seeing the prompt? press enter.

warning:
as usual, don't try on production systems unless you know what you're doing!

Lets check if you have tcpdump

`which tcpdump`{{ execute }}

/usr/sbin/tcpdump

And install  if not

`sudo apt install -y tcpdump`

Any time you need to break out of a cmd use ctrl-c, or click here:
`echo stop`{{ execute }}

### simple commands

Lets take a quick look at help,

 `tcpdump -h`{{execute}}

and lets see what interfaces are available on this machine

`tcpdump -D`{{ execute }}

since enp1s0 is our main interface, we'll be using the option `-i enp1s0`  or `-i 1`

lets capture the next 5 packets transvering ens3

`tcpdump -i enp1s0 -c 5`{{ execute }}

I don't want to see the dns entries (-n)

`tcpdump -i enp1s0 -c 5 -n`{{ execute }}

to really shorten up the output try `-q` minimum,  `-t` no time stamps

`tcpdump -i enp1s0 -c 5 -nqt`{{ execute }}

### basic tcpdump args:

```
 tcpdump    
    -D  # list the available interfaces
    -i <int name>  or any
    -c<#>  number of packets to capture
    -n      do not look up dns
    -s<#>   capture this much of a packet   max: 65335 just header: 64   0: max
    -S      do not show seq numbers, first capture shows complete seq num, rest show relipahte
    -e      show macs\' 
    -XX     more pkt detail   -A    more compact   -v -vv -vvv  -K ignore tcpdump collection errors
    -q      minimum output
    -t      no time,  -tt -ttttt max time info
    -w <filename.pcap>   # capture into a file, -v to show \ of pkts capture while in progress
    -r <file>   read file
```


### Lets try some basic filters

Look for DNS traffic using UDP on port 53
`tcpdump -i enp1s0 udp -c 3 -nt -u port 53`{{ execute }}


And lets send a ping to trigger a dns request in another terminal (type yes when prompted)

`ping -c 3 www.bbc.com`{{exec}}

WIP REMOVE:
`ssh root@node01 ping -c 5 www.bbc.com`{{execute HOST2}}

## Setup another tab

We are presently working on 'controlplane'

`hostname`{{exec}}

Next to 'tab 1' to open a second tab.

and lets connect to the other server

`ssh root@node01`{{exec}}


Lets send some pings to the controlplane

`ssh root@node01 ping -c 10 www.bbc.com`{{exec}}

Lets look for incoming traffic from node1 - **return to tab 1**

`tcpdump -i enp1s0  -c 3 -v -nt src host host02`{{ execute }}

To run more complex filters you should include them  in double quotes, so lets look for incoming traffic of type ssh.

`tcpdump -i enp1s0  -c 3 -v -nt "src host node01 || src port 22"`{{ execute HOST1 }}


[www.tcpdump.org  man page for tcpdump](https://www.tcpdump.org/manpages/tcpdump.1.html)



### short list of filter:

  1. host \<ip> or <dns name>
  2. net <cidr addr eg 10.0.0.0/24>
  3. [srx | dst] [host | net | other?]
  4. port <ip>  
  5. and | or   complex filters should be in  "" or ''
  6. tcp        protocol
  7. ether host <mac>    to filter my mac
  8. tcp udp      ipv6
  9. you can also filer on flags (see man)
  10. logical operaters (depending on the os) and = &&, or = ||, not = !  