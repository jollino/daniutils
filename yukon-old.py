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

def make_output(type1, type2, aet, count, date):
	output = f"{get_code(type1)} {get_code(type2)}\t"
	output += f"{float(aet)}\t"
	output += f"{count}\t"
	output += f"{date}"
	return output


def main():
	everything = sys.stdin.readlines()

	previous = {"type1": None, "type2": None, "aet": None}
	count_subtotal = 0
	output = ""

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

		# è il primo, inizializziamo un po' di roba
		if previous["type1"] is None: previous["type1"] = type1 
		if previous["type2"] is None: previous["type2"] = type2
		if previous["aet"] is None: previous["aet"] = aet

		if type1 != previous["type1"] or type2 != previous["type2"] or aet != previous["aet"]: # NON siamo in un batch
			#print("X")
			# non siamo in un batch, stampiamo il totale (usando i valori __vecchi__ altrimenti ce li perdiamo!) e prepariamo per il prossimo
			output = make_output(previous["type1"], previous["type2"], previous["aet"], count_subtotal, date)
			print(output)
			previous["type1"], previous["type2"], previous["aet"] = type1, type2, aet
			count_subtotal = 1 # ripartiamo da 1 perché già ne abbiamo 1 (questo)
			continue

		# siamo in un batch
		#print("B")
		count_subtotal += 1
		#print(count_subtotal)
	# l'ultimo lo dobbiamo comunque stampare così com'è
	#print("finito")
	output = make_output(previous["type1"], previous["type2"], previous["aet"], count_subtotal, date)
	print(output)



if __name__ == '__main__':
	main()
