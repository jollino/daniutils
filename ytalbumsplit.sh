#!/bin/bash

yt-dlp --split-chapters -x -o "%(playlist_index)s - %(channel)s - %(playlist_title)s - %(title)s.%(ext)s" -f bestaudio --audio-quality 0 --audio-format=mp3 $1