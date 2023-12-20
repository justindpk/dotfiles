#!/bin/sh

# Function to get the current playback status
get_playback_status() {
  playerctl status 2>/dev/null
}

# Maximum length for title and artist
max_title_length=20
max_artist_length=12

# Modified scroll_song_info function with artist handling
# Modified scroll_song_info function for rightward scrolling
scroll_song_info() {
  local scroll_title="$1"
  local scroll_artist="$2"
  local max_title_length="$3"
  local max_artist_length="$4"
  
  while true; do
    local status=$(get_playback_status)
    if [ "$status" = "Playing" ]; then
      local title_length=${#scroll_title}
      local artist_length=${#scroll_artist}

      # Scroll title to the right if necessary
      if [ $title_length -gt $max_title_length ]; then
        title_scroll="${scroll_title: -1:1}${scroll_title:0:$max_title_length-1}"
        scroll_title="${scroll_title: -1:1}${scroll_title:0:$((title_length - 1))}"
      else
        title_scroll="$scroll_title"
      fi

      # Scroll artist to the right if necessary
      if [ $artist_length -gt $max_artist_length ]; then
        artist_scroll="${scroll_artist: -1:1}${scroll_artist:0:$max_artist_length-1}"
        scroll_artist="${scroll_artist: -1:1}${scroll_artist:0:$((artist_length - 1))}"
      else
        artist_scroll="$scroll_artist"
      fi

      song_info="$title_scroll✦ $artist_scroll"
      echo " $song_info"
      eww update player_widget="$song_info"
      elif [ "$status" = "Paused" ]; then
      echo " $song_info"
    fi

    sleep 0.48
  done
}

# Function to handle song changes
onSongChange() {
  local current_song_info="$1"

  # Split the string into title and artist components
  local title=$(echo "$current_song_info" | awk -F ' - ' '{print $1}')

  # Extract the artist by getting the text after the last hyphen
  local artist=$(echo "$current_song_info" | awk -F ' - ' '{print $NF}')

  # Improved regex to remove 'feat.', 'ft.', etc., and everything in parentheses from the title
  title=$(echo "$title" | sed -E 's/\(.*\)|feat\..*|ft\..*|with\..*|\|.*//gi' | awk '{$1=$1;print}')

  # Trimming leading and trailing spaces from artist
  artist=$(echo "$artist" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

  # Append a space at the end for smooth looping, only if it doesn't already end with one
  [[ "${title: -1}" != " " ]] && title="${title} "
  [[ "${artist: -1}" != " " ]] && artist="${artist} "

  local scroll_title="$title"
  local scroll_artist="$artist"

  if [ ! -z "$scroll_pid" ]; then
    kill $scroll_pid
  fi

  scroll_song_info "$scroll_title" "$scroll_artist" $max_title_length $max_artist_length &
  scroll_pid=$!
}

# Poll for initial song value
initial_song=$(playerctl metadata --format '{{ title }} - {{ artist }}')
onSongChange "$initial_song"

playerctl --follow metadata --format '{{ title }} - {{ artist }}' | while read line; do
  onSongChange "$line"
done &

while true; do
  sleep 1
done

