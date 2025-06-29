#!/bin/bash

# Loop through all mp3 files in the current directory
for file in *.mp3; do
  # Extract the base filename without the extension
  base_name=$(basename "$file" .mp3)

  # Check if the second field is "NA"
  if [[ "$base_name" =~ ^([0-9]+)\ -\ NA\ -\ (.+)\ -\ (.+)\ -\ (.+)$ ]]; then
    track_number="${BASH_REMATCH[1]}"
    album="${BASH_REMATCH[2]}"
    artist="${BASH_REMATCH[3]}"
    title="${BASH_REMATCH[4]}"

    # Tag the mp3 file using id3v2
    echo "Tagging (NA format): $file"
    echo "Track: $track_number"
    echo "Artist: $artist"
    echo "Album: $album"
    echo "Title: $title"

    # Add tags to the file
    id3v2 -T "$track_number" -a "$artist" -A "$album" -t "$title" "$file"

  # Check for "Topic - Album" or just "Album"
  elif [[ "$base_name" =~ ^([0-9]+)\ -\ (.+)\ -\ Album\ -\ (.+)\ -\ (.+)$ ]]; then
	track_number="${BASH_REMATCH[1]}"
    artist="${BASH_REMATCH[2]}"
	artist="${artist% - Topic}"
	album="${BASH_REMATCH[3]}"
    title="${BASH_REMATCH[4]}"

    # Tag the mp3 file using id3v2
    echo "Tagging (normal format): $file"
    echo "Track: $track_number"
    echo "Artist: $artist"
    echo "Album: $album"
    echo "Title: $title"

    # Add tags to the file
    id3v2 -T "$track_number" -a "$artist" -A "$album" -t "$title" "$file"

  # Check for the new format
  elif [[ "$base_name" =~ ^(.+)\ -\ (.+)\ -\ ([0-9]+)\ (.+)\ \[.+\]$  ||  "$base_name" =~ ^(.+)\ -\ (.+)\ -\ ([0-9]+)\ -\ (.+)$ ]]; then
    artist="${BASH_REMATCH[1]}"
    album="${BASH_REMATCH[2]}"
    track_number="${BASH_REMATCH[3]}"
    title="${BASH_REMATCH[4]}"

    # Tag the mp3 file using id3v2
    echo "Tagging (new format): $file"
    echo "Artist: $artist"
    echo "Album: $album"
    echo "Track: $track_number"
    echo "Title: $title"

    # Add tags to the file
    id3v2 -a "$artist" -A "$album" -T "$track_number" -t "$title" "$file"

  else
    echo "File doesn't match expected format: $file"
  fi
done

