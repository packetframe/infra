#!/bin/bash
# vercheck.sh Packetframe control plane version checker

# TODO: Add docker tag checker

CONFIG_FILE=config/controlplane-versions.yml

symverlt() {
    [ "$1" = "$2" ] && return 1 || [  "$1" = "$(echo -e "$1\n$2" | sort -V | head -n1)" ]
}

API_VERSION=$(yq -r .controlplane_versions.docker.api $CONFIG_FILE)
WEB_VERSION=$(yq -r .controlplane_versions.archives.web $CONFIG_FILE)

LATEST_API_VERSION=$(curl https://api.github.com/repos/packetframe/api/releases/latest -s | jq .name -r | sed 's/v//')
LATEST_WEB_VERSION=$(curl https://api.github.com/repos/packetframe/web/releases/latest -s | jq .name -r | sed 's/v//')

if symverlt $API_VERSION $LATEST_API_VERSION; then
  echo "API out of date ($API_VERSION < $LATEST_API_VERSION)"

  if [[ "$1" == "fix" ]]; then
    sed -i "s/api: $API_VERSION/api: $LATEST_API_VERSION/" $CONFIG_FILE
    echo "Updated API from $API_VERSION to $LATEST_API_VERSION"
  fi
else
  echo "API version up to date ($API_VERSION)"
fi

if symverlt $WEB_VERSION $LATEST_WEB_VERSION; then
  echo "Web out of date ($WEB_VERSION < $LATEST_WEB_VERSION)"

  if [[ "$1" == "fix" ]]; then
    sed -i "s/web: $WEB_VERSION/web: $LATEST_WEB_VERSION/" $CONFIG_FILE
    echo "Updated web from $WEB_VERSION to $LATEST_WEB_VERSION"
  fi
else
  echo "Web version up to date ($WEB_VERSION)"
fi
