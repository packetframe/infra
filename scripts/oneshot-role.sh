#!/bin/bash
# Usage ./oneshot-role <role> <hosts>
# Example: ./oneshot-role.sh ./roles/common/firewall edge

role=$1
hosts=$2

echo "Running role $role on $hosts"
cat >tmp-playbook.yml <<EOF
- name: Run role $role on $hosts
  hosts: $hosts
  vars_files:
    - config/controlplane-versions.yml
    - config/edge-versions.yml
  roles:
    - role: "$role"
EOF

ansible-playbook -i hosts.yml tmp-playbook.yml
rm tmp-playbook.yml
