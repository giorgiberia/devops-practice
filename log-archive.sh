#!/bin/bash

# Check if the user provided the log directory as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <log-directory>"
    exit 1
fi

LOG_DIR=$1

# Check if the provided directory exists
if [ ! -d "$LOG_DIR" ]; then
    echo "Directory $LOG_DIR does not exist."
    exit 1
fi

# Create a new directory for storing archives if it doesn't exist
ARCHIVE_DIR="$LOG_DIR/archives"
mkdir -p "$ARCHIVE_DIR"

# Get the current date and time for the archive filename
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"

# Compress the logs into a tar.gz file
tar -czf "$ARCHIVE_DIR/$ARCHIVE_NAME" -C "$LOG_DIR" .

# Log the archive creation to a file
echo "Archived logs to $ARCHIVE_DIR/$ARCHIVE_NAME" >> "$LOG_DIR/archive.log"

echo "Logs archived successfully: $ARCHIVE_DIR/$ARCHIVE_NAME"
