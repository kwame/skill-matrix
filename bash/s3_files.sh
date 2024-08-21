#!/bin/bash

# specify the S3 bucket name
BUCKET_NAME="a_random_s3_bucket_name"

# specify the S3 directory
S3_DIRECTORY="Processing"

# specify the s3 archive directory
S3_ARCHIVE="Proessing/Archive/"

# append log
LOG_FILE="s3_files_execution.log"

# add a eader to the log file with date and time
echo "Execution on $(date)" >> "$LOG_FILE"

# get the s3 file list, store in an array
readarray -t FILES < <(aws s3 ls "s3://$BUCKET_NAME/$S3_DIRECTORY/" | awk '{print $4}' | grep -i '\.pdf$')

# verify command execution
if [ $? -ne 0 ]; then
  echo "Failed to list files in the S3 bucket. Please check configuration" | tee -a "$LOG_FILE"
  exit 1
fi

# loop through the array and print each file name
for file in "${FILES[@]}"; do
  FILENAME="$(basename "$file")"
  #echo "$FILENAME"
  aws s3 cp s3://$BUCKET_NAME/$S3_DIRECTORY/$FILENAME /opt/mn/nfs/integration/content/novartis/content/base/Default/Importers/MedicaidClaims/
  aws s3 mv s3://$BUCKET_NAME/$S3_DIRECTORY/$FILENAME s3://$BUCKET_NAME/$S3_ARCHIVE
  echo "Archiving file $FILENAME" >> "$LOG_FILE"
done

# log completion message
echo "Execution completed on $(date)" >> "$LOG_FILE"
echo "----------------------------------------" >> "$LOG_FILE"
