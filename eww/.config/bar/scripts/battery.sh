#!/bin/sh
CAPACITY="$(cat /sys/class/power_supply/BAT1/capacity)"
STATUS="$(cat /sys/class/power_supply/BAT1/status)"
# echo "Battery status: $STATUS"
if [[ $STATUS == "Discharging" ]]; then
  if [[ $CAPACITY -gt 90 ]]; then
    echo " $CAPACITY"
  elif [[ $CAPACITY -gt 75 ]]; then
    echo " $CAPACITY"
  elif [[ $CAPACITY -gt 50 ]]; then
    echo " $CAPACITY"
  elif [[ $CAPACITY -gt 15 ]]; then
    echo " $CAPACITY"
  elif [[ $CAPACITY -gt 0 ]]; then
    echo "  $CAPACITY"
  fi 
else
 if [[ $CAPACITY -gt 90 ]]; then
    echo " $CAPACITY" 
  elif [[ $CAPACITY -gt 75 ]]; then
    echo " $CAPACITY" 
  elif [[ $CAPACITY -gt 50 ]]; then
    echo " $CAPACITY"
  elif [[ $CAPACITY -gt 25 ]]; then
    echo " $CAPACITY"
  elif [[ $CAPACITY -gt 0 ]]; then
    echo " $CAPACITY" 
  fi  
fi
