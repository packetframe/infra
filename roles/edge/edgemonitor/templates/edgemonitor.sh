#!/bin/bash

NODE_HOSTNAME="{{ inventory_hostname }}"

withdraw=false
msg_out=""
DIG_COMMAND="kdig +time=5 +retry=1 +nsid ch id.server txt"
for ip in 66.248.234.2 66.248.234.3 2602:809:3004::2 2602:809:3004::3; do
  dig_result=$($DIG_COMMAND @"$ip" 2>&1)
  RESULT=$?
  if ! [ $RESULT -eq 0 ]; then
    withdraw=true
    msg_out+=$"\n\`\`\`\n$ $DIG_COMMAND @$ip\n"
    msg_out+="${dig_result}\n\`\`\`\n"
  fi
done

if $withdraw; then
  if [ ! -f /tmp/edgemonitor.node-disabled ]; then
      echo -e "Withdrawing node $NODE_HOSTNAME at $(date)\n$msg_out" | /usr/local/bin/betteruptime-incident "[Edge Monitor] DNS query failed on $NODE_HOSTNAME"
      # pathvector generate --withdraw
  fi
  touch /tmp/edgemonitor.node-disabled
else
  rm -f /tmp/edgemonitor.node-disabled
fi
