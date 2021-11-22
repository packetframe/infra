#!/bin/bash
# Packetframe infra ctl.sh

ROLE_NAMESPACE=controlplane
ROLE_NAME=firewall
HOST=controlplane
ansible -m import_role -a name=./roles/$ROLE_NAMESPACE/$ROLE_NAME $HOST -i hosts.yml
