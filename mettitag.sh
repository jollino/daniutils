#!/bin/bash

for file in *.mp3; do
  base_name=$(basename "$file" .mp3)

  if [[ "$base_name" =~ ^([0-9]+)\ -\ NA\ -\ (.+)\ -\ (.+)\ -\ (.+)$ ]]; then
    track_number="${BASH_REMATCH[1]}"
    album="${BASH_REMATCH[2]}"
    artist="${BASH_REMATCH[3]}"
    title="${BASH_REMATCH[4]}"

    echo "Tagging (NA format): $file"
    echo "Track: $track_number"
    echo "Artist: $artist"
    echo "Album: $album"
    echo "Title: $title"

    id3v2 -T "$track_number" -a "$artist" -A "$album" -t "$title" "$file"

  elif [[ "$base_name" =~ ^([0-9]+)\ -\ (.+)\ -\ (Topic\ -\ )?Album\ -\ (.+)\ -\ (.+)$ ]]; then
    track_number="${BASH_REMATCH[1]}"
    artist="${BASH_REMATCH[2]}"
    album="${BASH_REMATCH[4]}"
    title="${BASH_REMATCH[5]}"

    echo "Tagging (normal format): $file"
    echo "Track: $track_number"
    echo "Artist: $artist"
    echo "Album: $album"
    echo "Title: $title"

    id3v2 -T "$track_number" -a "$artist" -A "$album" -t "$title" "$file"

  elif [[ "$base_name" =~ ^(.+)\ -\ (.+)\ -\ ([0-9]+)\ (.+)\ \[.+\]$ ]]; then
    artist="${BASH_REMATCH[1]}"
    album="${BASH_REMATCH[2]}"
    track_number="${BASH_REMATCH[3]}"
    title="${BASH_REMATCH[4]}"

    echo "Tagging (new format): $file"
    echo "Artist: $artist"
    echo "Album: $album"
    echo "Track: $track_number"
    echo "Title: $title"

    id3v2 -a "$artist" -A "$album" -T "$track_number" -t "$title" "$file"

  else
    echo "File doesn't match expected format: $file"
  fi
done

