#!/usr/bin/env python3

source = input("Comma-separated list of tags:\n")
tags = [tag.strip() for tag in source.split(",")]
tags.sort()
igtags = ["#{}".format(tag.replace(" ", "")) for tag in tags]

print("\nSorted tags:")
print(", ".join(tags))

print("\nTags for instagram:")
print(" ".join(igtags))
