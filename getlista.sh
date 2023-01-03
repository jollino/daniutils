#!/bin/bash

#parallel --jobs 10 --arg-file lista.txt --ungroup 'youtube-dl --no-check-certificate -fbest -i -fbest -i --fragment-retries infinite --retries infinite "$l" --external-downloader aria2c --external-downloader-args " -x12 -s12 -j12 -k 1M " {}'
parallel --jobs 10 --arg-file lista.txt --ungroup 'yt-dlp --no-check-certificates -i --fragment-retries 50 --retries 50 "$l" --downloader aria2c {}'

#parallel --jobs 10 --arg-file lista.txt --ungroup 'youtube-dl -fbest -i --external-downloader axel --external-downloader-args "-a -n16" {}'
#parallel --jobs 10 --arg-file lista.txt --ungroup 'youtube-dl -fbest -i {}'
