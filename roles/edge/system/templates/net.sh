#!/bin/bash

ip link add local type dummy
ip addr add dev local 66.248.234.2/24 # ns1
ip addr add dev local 2602:809:3004::2/48 # ns1
ip addr add dev local 66.248.234.3/24 # ns2
ip addr add dev local 2602:809:3004::3/48 # ns2
ip addr add dev local 66.248.234.5/24 # Verfploeter
ip addr add dev local 2602:809:3004::5/48 # Verfploeter

# AS112
ip addr add dev local 192.175.48.1/32       #  prisoner.iana.org
ip addr add dev local 2620:4f:8000::1/128   #  prisoner.iana.org
ip addr add dev local 192.175.48.6/32       #  blackhole-1.iana.org
ip addr add dev local 2620:4f:8000::6/128   #  blackhole-1.iana.org
ip addr add dev local 192.175.48.42/32      #  blackhole-2.iana.org
ip addr add dev local 2620:4f:8000::42/128  #  blackhole-2.iana.org
ip addr add dev local 192.31.196.1/32       #  blackhole.as112.arpa
ip addr add dev local 2001:4:112::1/128     #  blackhole.as112.arpa

ip link set dev local up
