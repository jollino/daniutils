#!/usr/bin/env python3

# TDB: the data structure is hideous, probably should be thought over
# TBD: when split sessions exist (i.e. multiple entries for the same day), the "average per day worked value" is incorrect as it's summed up

import csv, sys, calendar

def invoice_to_minutes(invoice_time: str) -> int:
	"""'1 hours, 45 mins' => 105"""
	# TBD: redo this with regexp?
	chunks = invoice_time.split(", ")
	hours = 0
	if len(chunks) == 2:
		hours = int(chunks[0].split(" hours")[0])
	minutes = int(chunks[-1].split(" mins")[0])
	return hours * 60 + minutes

def days_in_month(date: str) -> int:
	"""'05/28/1984' => 31"""
	# takes a stupid US format date
	month, day, year = date.split("/")
	range = calendar.monthrange(int(year), int(month))
	return range[1]


def main():
	if len(sys.argv) < 2:
		print(f"Usage: {sys.argv[0]} <filename>")
		print("The output is TSV, with an explanatory header.")
		print("All values are in minutes, rounded to the next integer.")
		sys.exit(-1)

	filenames = sys.argv[1:]
	tot_minutes = 0
	tot_actual_days = 0
	tot_worked_days = 0
	tot_best = 0
	tot_worst = 0

	# TDB: should probably only print the header if we DO get valid output
	print("Filename\tMins. worked\tAvg. per day worked\tAvg. per mo's day\tBest day\tWorst day")

	for filename in filenames:
		month_minutes = 0
		actual_days = 30 # reasonable default?
		worked_days = 0
		best = 0
		worst = 0
		with open(filename) as sourcefile:
			rows = csv.reader(sourcefile)
			for row in rows:
				if rows.line_num == 1: # header, skip
					continue
				date, project, description, duration, *tail = row

				if rows.line_num == 2: # first actual line, get actual days
					actual_days = days_in_month(date)
					tot_actual_days += actual_days

				if project != "Yukon":
					continue

				minutes = invoice_to_minutes(duration)
				worked_days += 1
				month_minutes += minutes
				if minutes > best:
					best = minutes
				if worst == 0 or minutes < worst:
					worst = minutes

				if best > tot_best:
					tot_best = best
				if tot_worst == 0 or worst < tot_worst:
					tot_worst = worst

		print(f"{filename}\t{month_minutes}\t{int(month_minutes/worked_days)}\t{int(month_minutes/actual_days)}\t{int(best)}\t{int(worst)}")
		tot_minutes += month_minutes
		tot_worked_days += worked_days
	print(f"(total)\t{tot_minutes}\t{int(tot_minutes/tot_worked_days)}\t{int(tot_minutes/tot_actual_days)}\t{int(tot_best)}\t{int(tot_worst)}")


if __name__ == '__main__':
	main()