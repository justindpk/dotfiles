#!/bin/bash

net_status () {
	network_name=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d ':' -f2)

	if [ -n "$network_name" ]; then
    		echo " $network_name"
	else
    		echo "  Offline"
	fi
}

net_status
