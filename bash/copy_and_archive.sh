#!/bin/bash

# Variables
BUCKET_NAME="kwame-tf"
SOURCE_DIR="global/files/"
ARCHIVE_DIR="global/Archive/"
LOCAL_DOWNLOAD_DIR="/Users/kwame/Downloads/working"
LOG_FILE="/Users/kwame/Downloads/working/transaction.log"

# logging
echo "Archiving files on $(date)" >> "$LOG_FILE"

# array to store file names
declare -a FILE_ARRAY

# populate the array with S3 source directory files
echo "Listing files in s3://$BUCKET_NAME/$SOURCE_DIR" >> "$LOG_FILE"
while IFS= read -r file; do
    if [[ ! "$file" =~ .*/$ ]]; then
        FILE_ARRAY+=("$file")
    fi
done < <(aws s3 ls s3://$BUCKET_NAME/$SOURCE_DIR --recursive | awk '{print $4}')

# copy files to nfs in app server 
for file in "${FILE_ARRAY[@]}"; do
    aws s3 cp "s3://$BUCKET_NAME/$file" "$LOCAL_DOWNLOAD_DIR/"
    #echo "Copied $file to $LOCAL_DOWNLOAD_DIR" >> "$LOG_FILE"
    
    # move files to archive directory in S3
    ARCHIVE_PATH="$ARCHIVE_DIR$(basename "$file")"
    aws s3 mv "s3://$BUCKET_NAME/$file" "s3://$BUCKET_NAME/$ARCHIVE_PATH"
    echo "Archived file  $file" >> "$LOG_FILE"
done

# End logging
echo "Script ended at $(date)" >> "$LOG_FILE"
echo "----------------------------------" >> "$LOG_FILE"

