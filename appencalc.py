#!/usr/bin/env python3

import sys, re

def invoice_to_minutes(invoice_time: str) -> int:
	"""'1 hours, 45 mins' => 105"""
	# TBD: redo this with  regexp?
	chunks = invoice_time.split(", ")
	hours = 0
	if len(chunks) == 2:
		hours = int(chunks[0].split(" hours")[0])
	minutes = int(chunks[-1].split(" mins")[0])
	return hours * 60 + minutes


def main():
	everything = sys.stdin.readlines()
	is_yukon = False
	tot_minutes = 0
	for line in everything:
		if line[-1] == "\n":
			line = line[:-1]
		if line == "":
			continue
		chunks = [chunk.strip() for chunk in line.split("\t")]
		#print(">> " + line)
		#print(">> " + str(chunks))
		if "PROJECT" in chunks:
			if chunks[-1] == "Yukon":
				#print("!! YUKON !!")
				is_yukon = True
			else:
				#print("!! not yukon !!")
				is_yukon = False
			continue
		else: # not a project line, let's check for the amount
			if is_yukon:
				if len(chunks) == 1: # it's a comment only
					continue
				duration = chunks[0]
				#print("<< " + duration)
				minutes = invoice_to_minutes(duration)
				#print("=> " + str(minutes))
				tot_minutes += minutes
			else:				
				#print("not is_yukon, ignoring")
				pass
	print(f"\nTotal minutes of Yukon for month: {tot_minutes}")



if __name__ == '__main__':
	main()
