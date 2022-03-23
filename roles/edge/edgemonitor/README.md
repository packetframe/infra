# Edge Monitor

`edge-monitor` is a script that runs once a minute on every edge node. It runs a DNS query towards ns1/ns2 over IPv4 and IPv6 and if any queries fail, raises an incident then raises an incident.
