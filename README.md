router_simulator
================

Router:

A network router is a device which knows where to send which packet,. So if we
define that any packet for network address 1.1.1.1 to be sent to network device
A, so it will forward every packet for 1.1.1.1 to device A. Apart from these rules a
network router has a default gateway defined, so if a packet does not match any
rule it will send that to default gateway.

A network rule is defined by providing an IP Address followed by their netmask
and a destination machine, at the end followed by default gateway (optional)

You need to write a simple router simulator, which will be take input in terms
of number of routing rules followed by routing rules and then number of route
statements and followed by route statements. Your output will be routed
destination and if it can not route some packets then output should print NO
ROUTE DEFINED

Sample Input:
3
10.0.0.0 255.255.255.0 192.168.1.1
20.0.0.0 255.0.0.0 192.168.1.2
default 192.168.1.3
5
10.0.0.2
10.1.1.2
20.1.1.2
20.1.1.1
21.1.1.1

Sample Output:
192.168.1.1
192.168.1.3
192.168.1.2
192.168.1,2
192.168.1.3

Sample Input:
1
10.0.0.0 255.255.255.0 192.168.1.1
3
10.0.0.2
10.1.1.2
10.0.1.0

Sample Output:
192.168.1.1
NO ROUTE DEFINED
NO ROUTE DEFINED