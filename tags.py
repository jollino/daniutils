#!/usr/bin/env python3

import sys

source = input("Comma-separated or newline-separated (end with an extra newline) list of tags:\n")

if source == "": # abort!
    sys.exit("OK, nevermind!")

if "," in source:
    tags = [tag.strip() for tag in source.split(",")]
else:
    tags = []
    source = source.strip()
    if source != "": # copy and paste from flickr yields an empty first tag for some reason
        tags.append(source)
    while True:
        source = input().strip()
        if source == "":
            break
        tags.append(source)

tags.sort()
igtags = ["#{}".format(tag.replace(" ", "")) for tag in tags]

print("\nSorted tags:")
print(", ".join(tags))

print("\nTags for instagram:")
print(" ".join(igtags))
