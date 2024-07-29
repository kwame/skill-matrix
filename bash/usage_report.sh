#!/bin/bash

# Check if the user provided a directory argument
if [ "$#" -ne 1 ]; then
    directory="."
else
    directory=$1
fi

# Check if the provided argument is a valid directory
if [ ! -d "$directory" ]; then
    echo "Error: $directory is not a valid directory."
    exit 1
fi

# Create the report file
report_file="$directory/disk_usage_report.txt"
echo "Disk Usage Report for $directory" > "$report_file"
echo "" >> "$report_file"

# Get the total size of the directory
total_size=$(du -sh "$directory" | cut -f1)
echo "Total size of $directory: $total_size" >> "$report_file"
echo "" >> "$report_file"

# Get the size and file count for each subdirectory
echo "Subdirectory sizes:" >> "$report_file"
for subdir in "$directory"/*/; do
    subdir_size=$(du -sh "$subdir" | cut -f1)
    file_count=$(find "$subdir" -type f | wc -l)
    subdir_name=$(basename "$subdir")
    echo "- $subdir_name: $subdir_size, $file_count files" >> "$report_file"
done

echo "Report saved to $report_file"
