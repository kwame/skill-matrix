#!/bin/bash

# Check if the user provided the required arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <search_string> <directory>"
    echo ""
    echo "This script searches for a specified string in all files within the specified directory and its subdirectories."
    echo ""
    echo "Options:"
    echo "  -r: Search recursively through directories."
    echo "  -n: Display line numbers of matching lines."
    echo "  -w: Match the whole word."
    echo "  <directory>: The directory to start searching from."
    echo "  -e: Specify the search pattern (the string to search for)."
    exit 1
fi

search_string=$1
search_directory=$2

# Use the 'grep' command to search for the string in all files
grep -rnw "$search_directory" -e "$search_string"

# Explanation:
# -r: recursive
# -n: show line numbers
# -w: match the whole word
# <directory>: the directory to start searching from
# -e: the search pattern
