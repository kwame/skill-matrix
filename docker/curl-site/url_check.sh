#!/bin/sh

if [ -z "$URL_TO_CHECK" ]; then
  echo "No URL specified. Exiting." >> /app/logs/output.log
  exit 1
fi

echo "Checking URL: $URL_TO_CHECK" >> /app/logs/output.log
curl -Is $URL_TO_CHECK | head -n 1 >> /app/logs/output.log
echo "Check complete at $(date)" >> /app/logs/output.log

