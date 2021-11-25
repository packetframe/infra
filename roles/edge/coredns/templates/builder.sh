#!/bin/bash

corefile="/opt/packetframe/dns/Corefile"

echo "(pf_default) {
  nsid {{ inventory_hostname }}
}

. {
  import pf_default
  reload 10s
  prometheus localhost:9253
  bind 127.34.55.3
}
" >"$corefile"

for zone_file in /opt/packetframe/dns/zones/*; do
  zone=$(echo $zone_file | sed 's/\/opt\/packetframe\/dns\/zones\/db.//')
  echo "$zone {
  import pf_default
  file /opt/packetframe/dns/zones/db.$zone
}
" >>"$corefile"
done
