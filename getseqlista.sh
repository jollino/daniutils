#!/bin/bash

while read l; do
	#yt-dlp -fbest -i --fragment-retries infinite --retries infinite "$l"
	yt-dlp -i --fragment-retries 50 --retries 50 --no-check-certificates "$l"
done < lista.txt
