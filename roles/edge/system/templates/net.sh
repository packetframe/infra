#!/bin/bash

ip link add local type dummy
ip addr add dev local 66.248.234.2/24
ip addr add dev local 2602:809:3004::2/48
ip addr add dev local 66.248.234.3/24
ip addr add dev local 2602:809:3004::3/48
ip link set dev local up
