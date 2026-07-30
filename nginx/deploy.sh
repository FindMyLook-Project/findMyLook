#!/bin/bash
# Applies the tracked findmylook.conf to the live server, with a backup and a
# config test before reloading. Run from the findMyLook repo root, after
# pulling the latest changes. Requires sudo.
set -e

CONF_SRC="nginx/findmylook.conf"
CONF_DEST="/etc/nginx/conf.d/findmylook.conf"
BACKUP="$CONF_DEST.bak-$(date +%Y-%m-%d-%H%M%S)"

sudo cp "$CONF_DEST" "$BACKUP"
echo "Backed up current config to $BACKUP"

sudo cp "$CONF_SRC" "$CONF_DEST"
echo "Copied $CONF_SRC to $CONF_DEST"

sudo nginx -t
echo "Config test passed - reloading nginx"

sudo systemctl reload nginx
echo "Done."
