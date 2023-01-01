#!/bin/bash

extra=''; for f in *MP4; do echo -e "file '$f'\n$extra" >> lista.txt; extra='inpoint 1'; done
ffmpeg -f concat -safe 0 -i lista.txt -c copy -scodec copy tutto.mp4
# nextbase
#echo -e > lista.txt
#for f in *MP4; do echo "file $f" >> lista.txt; done
#ffmpeg -f concat -safe 0 -i lista.txt -c:v copy -c:a aac -b:a 128k tutto.mp4
