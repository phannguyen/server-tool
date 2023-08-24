#!/bin/bash
# Sync backup files modified in a days to other server.

# Source directory.
SOURCE_DIR="/path/to/source/"

# Destination directory.
DEST_DIR="user@example.com:/path/to/destination/"

# Error log file.
LOG_FILE="/var/log/sync_error.log"

# SSH port.
SSH_PORT=22

# Number of days to keep file source.
DAYS = 10

cd $SOURCE_DIR

# Find all files in source directory.
# rsync -avz: -a archive mode; -v verbose; -z compress file data during the transfer
# --quiet no output
# --remove-source-files delete files from source after transfer
find . -type f -mtime +$DAYS -print0 | rsync -avz -e "ssh -p $SSH_PORT" --files-from=- --from0 ./ "$DEST_DIR" --remove-source-files || echo "`date`: Rsync failed for $SOURCE_DIR to $DEST_DIR" >> "$LOG_FILE"

