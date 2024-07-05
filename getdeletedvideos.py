#!/usr/bin/env python3

import subprocess
import sys
import os
import json
import datetime, time
import csv

def main():
    try:
        directory = sys.argv[1]
    except IndexError:
        directory = "."
    print(f"Working on directory {directory}")

    try:
        csvfilename = sys.argv[2]
    except IndexError:
        csvfilename = "output-" + time.strftime("%Y%m%d-%H%M%S") + ".csv"
    print(f"Output file is {csvfilename}")

    
    videoids = {}
    for filename in os.listdir(directory):
        if not filename.endswith(".sh") and not filename.endswith(".txt") and not filename.startswith("."):
            videoid = filename.split(".")[-2][-11:]
            videoids[videoid] = filename
    # i=0
    # for videoid in videoids:
    #     i+=1
    #     print(f"{i} {videoid}")
    # sys.exit()
    howmany = len(videoids)
    
    results = []
    i=0
    for videoid, filename in videoids.items():
        i+=1
        result = {"id": videoid}
        print(f"[{i}/{howmany}] {videoid}... ", end="")
        sys.stdout.flush()

        check = subprocess.run(["yt-dlp", "--quiet", "--no-download", "--dump-json", f"https://www.youtube.com/watch?v={videoid}"], capture_output=True)
        if check.returncode == 0:
            print("exists")
            result["status"] = "exists"
            metadata = json.loads(check.stdout.decode())
            result["title"] = metadata["title"]
            result["channel"] = metadata["channel"]
            result["uploaded_on"] = datetime.date.fromtimestamp(metadata["timestamp"]).strftime("%Y-%m-%d")
            result["uploader"] = metadata["uploader"]
            result["uploader_id"] = metadata["uploader_id"]
            result["uploader_url"] = metadata["uploader_url"]
            result["duration"] = metadata["duration_string"]
        else:
            print("does NOT exist")
            result["status"] = "not found"
            result["title"] = filename
            result["error"] = check.stderr.decode().strip()
        #print(result)
        results.append(result)
        
    with open(csvfilename, "w", newline="") as csvfile:
        writer = csv.DictWriter(csvfile, ["id", "status", "error", "title", "channel", "uploaded_on", "uploader", "uploader_id", "uploader_url", "duration"])
        writer.writeheader()
        writer.writerows(results)
        print(f"Written results to {csvfilename}")
                    
if __name__ == "__main__":
    main()
    