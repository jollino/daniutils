#!/bin/bash

mkdir _fatto 2>/dev/null
for f in *MP4; do ffmpeg -i $f -ss 1 -vcodec copy -acodec copy _trimmed_$f; mv $f _fatto; done
