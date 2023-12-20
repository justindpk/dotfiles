#!/bin/bash

API_KEY="CUBGMCXUUBV2W5TIREJ9I9E7DSC3EQRVKI"
URL="https://api.etherscan.io/api?module=gastracker&action=gasoracle&apikey=$API_KEY"

# Fetch and parse gas price
gas_price=$(curl -s "$URL" | jq -r '.result.ProposeGasPrice')

echo "$gas_price"

