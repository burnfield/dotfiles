#!/bin/bash
if nmcli -t -f TYPE,STATE con show --active 2>/dev/null | grep -q "^vpn:activated"; then
    echo "VPN 🟢"
else
    echo "VPN 🔴"
fi
