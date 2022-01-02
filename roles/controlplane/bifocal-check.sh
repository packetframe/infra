#!/bin/bash
# Packetframe DNS reachability tester
# See https://github.com/natesales/bifocal for more information

DIG_COMMAND="dig +time=5 +tries=1 +nsid CH id.server TXT"
MTR_COMMAND="mtr --show-ips --report-wide --aslookup"
PROMPT="$"

for target in 66.248.234.2 66.248.234.3 2602:809:3004::2 2602:809:3004::3; do
  dig_result=$($DIG_COMMAND @"$target")
  RESULT=$?
  mtr_result=$($MTR_COMMAND $target 2>&1)
  if ! [ $RESULT -eq 0 ] && ! [[ "$mtr_result" =~ .*"Network is unreachable".* ]]; then
    echo "$PROMPT $DIG_COMMAND @$target"
    echo "$dig_result"
    echo
    echo "$PROMPT $MTR_COMMAND $target"
    echo "$mtr_result"
  fi
done
