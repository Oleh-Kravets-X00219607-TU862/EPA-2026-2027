#!/bin/bash

# Show the correct way to run this script
usage() {
    echo "Usage: $0 [MAX_NUM_CORES]"
}

# Display usage when the first parameter is missing
if [ -z "$1" ]; then
    usage
    exit 1
fi

# Check that the supplied number is valid
if ! [[ "$1" =~ ^[1-9][0-9]*$ ]]; then
    echo "ERROR: Enter a positive whole number of CPU cores."
    usage
    exit 1
fi

# Count the number of CPUs on this VM
num_cpu=$(grep '^processor' /proc/cpuinfo | wc -l)

# Print an error if there are fewer CPUs than required
if [ "$num_cpu" -lt "$1" ]; then
    echo "ERROR: Not enough CPU cores. Available: $num_cpu; required: $1."
    exit 1
else
    echo "OK: Enough CPU cores. Available: $num_cpu; required: $1."
fi

# New Bash command 1: printf displays a formatted prompt
printf 'Do you want to continue with installation? (y/n): '

# New Bash command 2: read accepts a response from the user
read -r answer

if [ "$answer" = "y" ]; then
    echo "The CPU check passed. The user chose to continue."
elif [ "$answer" = "n" ]; then
    echo "The user chose not to continue."
else
    echo "ERROR: Please enter y or n."
    exit 1
fi

# Explain the two selected commands and their benefits
printf 'read: accepts input and lets the user choose whether to continue.\n'
printf 'printf: displays formatted text and gives a clear prompt.\n'
