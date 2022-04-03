#!/bin/bash

wg_privkey=$(wg genkey)
wg_pubkey=$(echo $wg_privkey | wg pubkey)

echo "wg:
  priv: $wg_privkey
  publ: $wg_pubkey"
