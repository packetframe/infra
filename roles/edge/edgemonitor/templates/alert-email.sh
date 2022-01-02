#!/bin/bash
# Usage: echo "email body" | alert-email.sh "subject here"

echo "From: {{ config.email.username }}
Subject: $1

$(cat)" | ssmtp {{ config.email.recipient }}
