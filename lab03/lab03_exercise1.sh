#!/bin/bash
# Lab03 - Exercise 1: check the number of processes.
# Example: ./lab03_exercise1.sh 15
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
# Count the lines from ps, then subtract its heading line.
# pipefail lets us detect a failure in either command of the pipe.
set -o pipefail
if ! ct=$(ps -ef | wc -l); then
 echo "Error: could not count processes." >&2
 exit 1
fi
ct=$((ct - 1))
# Only a count greater than the limit exceeds the maximum.
if [ "$ct" -gt "$1" ]; then
 echo "Maximum number of processes exceeded"
else
 echo "The maximum number of processes NOT exceeded"
fi
