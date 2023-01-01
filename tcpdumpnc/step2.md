## overview of nc

Netcat (nc) is a utility for reading and writing directly from a network connection (tcp and udp)

Lets see if ssh is running on port 22 on this server, since tcp protocol is the default there is no need to define it. (-u will specify UDP)

`nc localhost 22`{{execute}}

we'll see a responce back from the server `SSH-2.0-OpenSSH_7.6p1 Ubuntu-4ubuntu0.3` 

`echo stop`{{ execute }} 
or ctrl-C


Lets setup a simple server on host1 with `-l` for listen and on port 1234 `-p 1234

`nc -l -p 1234`{{execute}}

and connect to it on the other server - host2

Connnect to Terminal Host 2 and run.
`nc host01 1234`{{ execute HOST2 }}

Now try sending messages between each server, to quit just use **ctrl-c**

if you're not getting the output you expect you can use `-v` or `-vv` for verbose output to help trouble shoot.

in fact, lets try connecting to  googles dns service on UDP 53 (put the -u before the host)

`nc -vv -u 8.8.8.8 53`{{execute}}

should return: Connection to 8.8.8.8 53 port [udp/domain] succeeded!

and disconnect **ctrl-C**

Next up, lets try a little port scanning with `-z`, and this time like tcpdump we'll use `-n` to suppress name resolution. The last argument here specifies the port range 1 to 30

`nc -vv -z  host02 1-30`{{execute}}

Looks like ssh is only open in this range


### resources

[wikipedia with examples](https://en.wikipedia.org/wiki/Netcat)

[netcat offical site](http://nc110.sourceforge.net/)
