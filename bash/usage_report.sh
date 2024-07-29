#!/bin/bash

# Function to generate the disk usage report
generate_report() {
    local dir=$1
    local report=$2

    echo "Disk Usage Report for $dir" > "$report"
    echo "" >> "$report"

    # Get the total size of the directory
    total_size=$(du -sh "$dir" | cut -f1)
    echo "Total size of $dir: $total_size" >> "$report"
    echo "" >> "$report"

    # Get the size and file count for each subdirectory
    echo "Subdirectory sizes:" >> "$report"
    for subdir in "$dir"/*/; do
        subdir_size=$(du -sh "$subdir" | cut -f1)
        file_count=$(find "$subdir" -type f | wc -l)
        subdir_name=$(basename "$subdir")
        echo "- $subdir_name: $subdir_size, $file_count files" >> "$report"
    done

    echo "Report saved to $report"
}

# Function to send the report via email
send_report() {
    local report=$1
    local email=$2
    mail -s "Disk Usage Report for $directory" "$email" < "$report"
    echo "Report sent to $email"
}

# Main script
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <directory> [email_address]"
    exit 1
fi

directory=$1
email_address=$2

# Check if the provided argument is a valid directory
if [ ! -d "$directory" ]; then
    echo "Error: $directory is not a valid directory."
    exit 1
fi

# Create the report file
report_file="$directory/disk_usage_report.txt"

# Generate the disk usage report
generate_report "$directory" "$report_file"

# Check if an email address was provided and send the report
if [ -n "$email_address" ]; then
    send_report "$report_file" "$email_address"
fi
