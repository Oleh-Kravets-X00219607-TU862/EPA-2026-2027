#!/bin/bash
# Lab03 - Exercise 3: choose screen output or file output.
# Examples: ./lab03_exercise3.sh 15 screen
# ./lab03_exercise3.sh 15 file
# The first argument is the limit; the second selects the output.
if [ "$#" -ne 2 ]; then
 echo "Usage: $0 <maximum_processes> <screen|file>" >&2
 exit 1
fi
# Reject negative numbers, text and values outside Bash's integer range.
if ! [ "$1" -ge 0 ] 2>/dev/null; then
 echo "Error: enter a non-negative whole number." >&2
 exit 1
fi
# Accept only the two supported output choices.
if [ "$2" != "screen" ] && [ "$2" != "file" ]; then
 echo "Error: choose screen or file." >&2
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
# Store the result so that either output mode can use it.
if [ "$ct" -gt "$1" ]; then
 message="Maximum number of processes exceeded"
else
 message="The maximum number of processes NOT exceeded"
fi
# Write the result to the selected destination.
if [ "$2" = "screen" ]; then
 echo "$message"
else
 logfile="process_log.txt"
 timestamp=$(date '+%Y-%m-%d %H:%M:%S')
 echo "$timestamp - $message" >> "$logfile"
fi
