#!/bin/bash

ffmpeg -i tutto.mp4 -vf setpts=PTS/5 -an -movflags +faststart tutto5x.mp4 # 5x
# ffmpeg -i tutto.mp4 -c:v libx264 -preset veryfast -crf 18 -vf setpts=PTS/5 -an -pix_fmt yuv420p -movflags +faststart _tutto5x.mp4