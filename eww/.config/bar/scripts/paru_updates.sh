#!/bin/sh

pluralize() {
    count=$1
    if [ "$count" -eq 1 ]; then
        echo "1 delivery"
    else
        echo "$count deliveries"
    fi
}

# Initial count
prev_count=$(paru -Qu | wc -l)
pluralize $prev_count

# Infinite loop to monitor updates
while true; do
    sleep 120  # Check every x seconds
    current_count=$(paru -Qu | wc -l)

    if [ "$current_count" -ne "$prev_count" ]; then
        pluralize $current_count
        prev_count=$current_count
    fi
done

