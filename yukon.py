#!/usr/bin/env python

import sys

CODES = {
	"Experimental": "EXP",
	"Side By Side": "SxS",
	"News and Blogs": "N&B",
	"Search Product": "S. Product"
}

def get_converted_date(timestamp):
	"""11/2/2022 10:04:09 => 2022-02-11"""
	date, time = timestamp.split()
	month, day, year = date.split("/")
	if len(day) < 2:
		day = "0" + day
	if len(month) < 2:
		month = "0" + month
	newdate = f"{year}-{month}-{day}"
	return newdate

def get_code(word):
	if word in CODES:
		return CODES[word]
	return word

def make_output(counts, date):
	#TODO make sure date works across multiple days
	output = "\n"
	for tasktype in counts:
		print(tasktype)
		type1, type2, aet = tasktype.split("|")
		thetype = type1 if type2 == "X" else type2
		#type2 = type2 if type2 != "X" else ""
		#type1 = type2 if type2 != "X" else ""
		count = counts[tasktype]
		output += f"{thetype}\t"
		output += f"{float(aet)}\t"
		output += f"{count}\t"
		output += f"{date}\n"
	return output


def main():
	everything = sys.stdin.readlines()
	counts = {}

	for line in everything:
		if line[-1] == "\n":
			line = line[:-1]
		if line == "":
			continue
		chunks = line.split('\t')
		chunks = [chunk.strip() for chunk in chunks]
		#print(chunks)
		id, timestamp, aet, type2, type1 = chunks
		date = get_converted_date(timestamp)
		#tasktype = f"{get_code(type1)}|{get_code(type2)}|{aet}"
		if type2 == "X":
			tasktype = f"{get_code(type1)}|X|{aet}"
		else:
			tasktype = f"{get_code(type2)}|X|{aet}"

		#print(tasktype)
		if tasktype in counts:
			counts[tasktype] += 1
		else:
			counts[tasktype] = 1

	output = make_output(counts, date) # TODO check date in the source
	print(output)

if __name__ == '__main__':
	main()
