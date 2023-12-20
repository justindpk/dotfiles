#!/bin/bash

# Get the current workspace number
current_workspace=$(hyprctl activeworkspace | awk '/workspace ID/ {print $3}')

# Initialize workspace indicators
workspace_indicators=""

# Loop through your workspaces
for i in {1..6}; do
  if [ "$i" -eq "$current_workspace" ]; then
    # Current workspace - hollow circle
    workspace_indicators+=" ● "
  else
    # Other workspace - solid circle
    workspace_indicators+=" ○ "
  fi
done

# Update the eww widget
echo "$workspace_indicators"

