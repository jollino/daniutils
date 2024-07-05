#!/bin/bash

for f in "$1"/*; do
	bn=$(basename "$f")
	echo $bn
	ffmpeg -ss "$(bc -l <<< "$(ffprobe -loglevel error -of csv=p=0 -show_entries format=duration "$f")*0.5")" -i "$f" -frames:v 1 "$bn.png"
done