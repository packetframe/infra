#!/usr/bin/python3

import sys
import requests

BETTERUPTIME_APIKEY = "{{ config.betteruptime_apikey }}"

r = requests.post(
    "https://betteruptime.com/api/v2/incidents",
    json={"summary": sys.argv[1], "requester_email": "noreply@packetframe.com", "description": sys.stdin.read(), "email": True},
    headers={"Authorization": "Bearer " + BETTERUPTIME_APIKEY, "Content-Type": "application/json"}
)
