#!/bin/bash

echo "Configuring NordVPN settings..."
mkdir -p /home/nordvpn/.config/NordVPN
echo '{"acceptTelemetry": true, "acceptMarketing": false}' > /home/nordvpn/.config/NordVPN/settings.json

echo "Attempting NordVPN login with token..."
if [ -z "$NORDVPN_TOKEN" ]; then
  echo "Error: NORDVPN_TOKEN environment variable not set"
  exit 1
fi

echo "Initializing nordvpn"
/etc/init.d/nordvpn start \
  && sleep 5 \
  && echo "Nordvpn Initialized"

# Use printf to automatically answer prompts and avoid interactive input
printf "y\nn\n" | nordvpn login --token "$NORDVPN_TOKEN"

# Check if login was successful by testing a simple command
if nordvpn status > /dev/null 2>&1; then
  echo "Login completed successfully."
else
  echo "Warning: Login may have failed but continuing..."
fi

# Connecting
nordvpn connect

tail -f /var/log/nordvpn/daemon.log
