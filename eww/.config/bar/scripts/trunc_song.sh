#!/bin/bash

song_info=$(playerctl --follow metadata --format '{{ title }} - {{ artist }}')

# Truncate the song info to a maximum length
max_length=30
truncated_song_info=${song_info:0:max_length}

# If the original string was longer, append '...'
if [ ${#song_info} -gt $max_length ]; then
    truncated_song_info="$truncated_song_info..."
fi

echo $truncated_song_info

