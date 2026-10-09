#!/bin/bash

# Count the number of CPUs on this VM
num_cpu=$(grep '^processor' /proc/cpuinfo | wc -l)

# Check for an invalid or missing required CPU count
if ! [[ "$1" =~ ^[1-9][0-9]*$ ]]; then
    echo "ERROR: Enter a positive whole number of CPU cores."
    exit 1
fi

# Print an error if there are fewer CPUs than required
if [ "$num_cpu" -lt "$1" ]; then
    echo "ERROR: Not enough CPU cores. Available: $num_cpu; required: $1."
    exit 1
else
    echo "OK: Enough CPU cores. Available: $num_cpu; required: $1."
fi
