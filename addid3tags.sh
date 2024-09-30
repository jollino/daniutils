#!/bin/bash

# Reference:
# yt-dlp -x -o "%(playlist_index)s - %(channel)s - %(playlist_title)s - %(title)s.%(ext)s" -f bestaudio --audio-quality 0 --audio-format=mp3

for file in *.mp3; do
  base_name=$(basename "$file" .mp3)

  # Sometimes the second field is "NA"
  if [[ "$base_name" =~ ^([0-9]+)\ -\ NA\ -\ (.+)\ -\ (.+)\ -\ (.+)$ ]]; then
    track_number="${BASH_REMATCH[1]}"
    album="${BASH_REMATCH[2]}"
    artist="${BASH_REMATCH[3]}"
    title="${BASH_REMATCH[4]}"

    echo "Tagging ('NA' format): $file"
    echo "Track: $track_number"
    echo "Artist: $artist"
    echo "Album: $album"
    echo "Title: $title"

    id3v2 -T "$track_number" -a "$artist" -A "$album" -t "$title" "$file"

  # Other times it's all about "Topic - Album"
  elif [[ "$base_name" =~ ^([0-9]+)\ -\ (.+)\ -\ Topic\ -\ Album\ -\ (.+)\ -\ (.+)$ ]]; then
    track_number="${BASH_REMATCH[1]}"
    artist="${BASH_REMATCH[2]}"
    album="${BASH_REMATCH[3]}"
    title="${BASH_REMATCH[4]}"

    echo "Tagging ('Topic' format): $file"
    echo "Track: $track_number"
    echo "Artist: $artist"
    echo "Album: $album"
    echo "Title: $title"

    id3v2 -T "$track_number" -a "$artist" -A "$album" -t "$title" "$file"

  else
    echo "File doesn't match expected format: $file"
  fi
done
