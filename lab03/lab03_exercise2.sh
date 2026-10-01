#!/bin/bash
# Lab03 - Exercise 2: append a dated result to a log file.
# Example: ./lab03_exercise2.sh 15
# The script needs one command-line argument.
if [ "$#" -ne 1 ]; then
 echo "Usage: $0 <maximum_processes>" >&2
 exit 1
fi
# Reject negative numbers, text and values outside Bash's integer range.
if ! [ "$1" -ge 0 ] 2>/dev/null; then
 echo "Error: enter a non-negative whole number." >&2
 exit 1
fi
# Count processes without including the heading line.
# pipefail lets us detect a failure in either command of the pipe.
set -o pipefail
if ! ct=$(ps -ef | wc -l); then
 echo "Error: could not count processes." >&2
 exit 1
fi
ct=$((ct - 1))
# The log is stored in the directory where the script is run.
logfile="process_log.txt"
timestamp=$(date '+%Y-%m-%d %H:%M:%S')
# Append one dated line; keep any earlier log entries.
if [ "$ct" -gt "$1" ]; then
 echo "$timestamp - Maximum number of processes exceeded" >> "$logfile"
else
 echo "$timestamp - The maximum number of processes NOT exceeded" >> "$logfile"
fi
