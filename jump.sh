#!/bin/bash

#ROLE_NAMESPACE=controlplane
#ROLE_NAME=firewall
#HOST=controlplane
#ansible -m import_role -a name=./roles/$ROLE_NAMESPACE/$ROLE_NAME $HOST -i hosts.yml

SSH_PORT=$(yq -r ".all.vars.config.edge.ssh.port" hosts.yml)
SSH_KEY_FILE=$(yq -r ".all.vars.ansible_ssh_private_key_file" hosts.yml)
command="ssh root@$(yq -r .hosts.children.edge.hosts.$1.ansible_host hosts.yml) -p $SSH_PORT -J vpn.fmt2 -i $SSH_KEY_FILE"
echo "$command"
$command
