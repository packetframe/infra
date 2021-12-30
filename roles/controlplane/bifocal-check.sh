#!/bin/bash
# Packetframe DNS reachability tester
# See https://github.com/natesales/bifocal for more information

DIG_COMMAND="dig +time=5 +tries=1 +nsid CH id.server TXT"
MTR_COMMAND="mtr --show-ips --report-wide --aslookup"
TARGET4="66.248.234.2"
TARGET6="2602:809:3004::2"
PROMPT="$"

dig4=$($DIG_COMMAND @"$TARGET4")
RESULT=$?
mtr4=$($MTR_COMMAND $TARGET6 2>&1)
if ! [ $RESULT -eq 0 ] && ! [[ "$mtr4" =~ .*"Network is unreachable".* ]]; then
  echo "$PROMPT $DIG_COMMAND @$TARGET4"
  echo "$dig4"
  echo
  echo "$PROMPT $MTR_COMMAND $TARGET4"
  eval $MTR_COMMAND $TARGET4
fi

dig6=$($DIG_COMMAND @"$TARGET6")
RESULT=$?
mtr6=$($MTR_COMMAND $TARGET6 2>&1)
if ! [ $RESULT -eq 0 ] && ! [[ "$mtr6" =~ .*"Network is unreachable".* ]]; then
  echo "$PROMPT $DIG_COMMAND @$TARGET6"
  echo "$dig6"
  echo
  echo "$PROMPT $MTR_COMMAND $TARGET6"
  eval "$MTR_COMMAND" $TARGET6
fi
