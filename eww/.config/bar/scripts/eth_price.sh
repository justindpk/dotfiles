#!/bin/sh

API_KEY="CUBGMCXUUBV2W5TIREJ9I9E7DSC3EQRVKI"
URL="https://api.etherscan.io/api?module=stats&action=ethprice&apikey=$API_KEY"

# Fetch and parse ETH price
eth_price=$(curl -s "$URL" | jq -r '.result.ethusd')

printf "%.2f\n" "$eth_price"
