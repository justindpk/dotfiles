#!/bin/sh

# Extract the line containing "last full capacity"
battery_info=$(acpi -V | grep "last full capacity")

# Extract the battery health percentage
battery_health=$(echo $battery_info | awk -F '=' '{print $2}' | tr -d ' %')

# Output the battery health percentage
echo "$battery_health"


