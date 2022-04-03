#!/bin/bash

ip link add local type dummy
ip addr add dev local 66.248.234.2/24 # ns1
ip addr add dev local 2602:809:3004::2/48 # ns1
ip addr add dev local 66.248.234.3/24 # ns2
ip addr add dev local 2602:809:3004::3/48 # ns2
ip addr add dev local 66.248.234.5/24 # Verfploeter
ip addr add dev local 2602:809:3004::5/48 # Verfploeter
ip addr add dev local 66.248.234.6/24 # SCRIPT
ip addr add dev local 2602:809:3004::6/48 # SCRIPT

# AS112
# ip addr add dev local 192.175.48.1/24       #  prisoner.iana.org
# ip addr add dev local 2620:4f:8000::1/48    #  prisoner.iana.org
# ip addr add dev local 192.175.48.6/24       #  blackhole-1.iana.org
# ip addr add dev local 2620:4f:8000::6/48    #  blackhole-1.iana.org
# ip addr add dev local 192.175.48.42/24      #  blackhole-2.iana.org
# ip addr add dev local 2620:4f:8000::42/48   #  blackhole-2.iana.org
# ip addr add dev local 192.31.196.1/24       #  blackhole.as112.arpa
# ip addr add dev local 2001:4:112::1/48      #  blackhole.as112.arpa

ip link set dev local up
