ssh_port := `yq -r .all.vars.config.edge.ssh.port hosts.yml`
ssh_key_file := `yq -r ".all.vars.ansible_ssh_private_key_file" hosts.yml`

list-roles:
    @find roles -type d | grep -v '/tasks' | grep -v '/templates' | sed 's/^roles\///g' | grep '/'

update-bgp host:
    ./scripts/oneshot-role.sh ./roles/edge/bgp "{{host}}"

install host:
    ansible-playbook -i hosts.yml scripts/all.yml --limit "{{host}}"

jump host:
    ssh root@$(yq -r .hosts.children.edge.hosts.{{host}}.ansible_host hosts.yml) -p {{ssh_port}} -J vpn.fmt2 -i {{ssh_key_file}}

controlplane-install:
    ansible-playbook -i hosts.yml scripts/controlplane-install.yml

controlplane-refresh:
    ansible-playbook -i hosts.yml scripts/controlplane-refresh.yml

lg-refresh:
    ansible-playbook -i hosts.yml scripts/lg.yml
