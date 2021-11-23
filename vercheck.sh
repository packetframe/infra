#!/bin/bash
# vercheck.sh Packetframe control plane version checker

symverlt() {
    [ "$1" = "$2" ] && return 1 || [  "$1" = "`echo -e "$1\n$2" | sort -V | head -n1`" ]
}

API_VERSION=$(yq -r .all.vars.config.controlplane.versions.docker.api hosts.yml)
WEB_VERSION=$(yq -r .all.vars.config.controlplane.versions.archives.web hosts.yml)

LATEST_API_VERSION=$(curl https://api.github.com/repos/packetframe/api/releases/latest -s | jq .name -r | sed 's/v//')
LATEST_WEB_VERSION=$(curl https://api.github.com/repos/packetframe/web/releases/latest -s | jq .name -r | sed 's/v//')

symverlt $API_VERSION $LATEST_API_VERSION && echo "API out of date ($API_VERSION < $LATEST_API_VERSION)" || echo "API version up to date ($API_VERSION)"
symverlt $WEB_VERSION $LATEST_WEB_VERSION && echo "Web out of date ($WEB_VERSION < $LATEST_WEB_VERSION)" || echo "Web version up to date ($WEB_VERSION)"

# TODO: Add docker tag checker
