#!/bin/bash

ip link add local type dummy
ip addr add dev local 66.248.234.2/24 # ns1
ip addr add dev local 2602:809:3004::2/48 # ns1
ip addr add dev local 66.248.234.3/24 # ns2
ip addr add dev local 2602:809:3004::3/48 # ns2
ip addr add dev local 66.248.234.5/24 # Verfploeter
ip addr add dev local 2602:809:3004::5/48 # Verfploeter
ip link set dev local up
