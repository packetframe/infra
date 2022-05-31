#!/bin/bash
# vertexd - vertex firewall rule manager

interface="{{ interface }}"
refresh_interval=5 # seconds
cache=""

while true; do
  current_filters=$(curl -s http://172.16.90.1:8080/generate)

  # Check if current filters are different from the cache
  if [ "$current_filters" != "$cache" ]; then
    # If they are different, update the cache
    cache=$current_filters

    # Apply the new filters
    echo "Applying new filters:"
    echo "$current_filters"
    echo

    echo 'interface = "'$interface'";
updatetime = 0;
    ' > /etc/xdpfw/xdpfw.conf
    echo "$current_filters" >> /etc/xdpfw/xdpfw.conf
    systemctl restart xdpfw
  fi
  sleep "$refresh_interval"
done
