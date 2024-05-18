#!/bin/bash

for jpg_file in *.JPG; do
	dng_file="${jpg_file%.JPG}.DNG"
  
	if [[ -f "$dng_file" ]]; then
		echo -n "$dng_file ..."
		exiftool -tagsFromFile "$jpg_file" -gps:all "$dng_file"
	else
		echo "No corresponding DNG file found for $jpg_file"
	fi
done

rm -f *_original
