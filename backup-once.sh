#!/bin/bash
# One-shot backup + prune. Use with cron for no persistent process.
# Example: 0 0 * * * /home/elijah/Downloads/Minecraft_Server/backup-once.sh

set -e
cd "$(dirname "$0")"

MAX_BACKUPS=3
BACKUP_PATTERN="world-backup-*.tar.gz"

./backup-worlds.sh

# Keep only 3 newest, delete the rest
count=$(ls -1 $BACKUP_PATTERN 2>/dev/null | wc -l)
if [ "$count" -gt "$MAX_BACKUPS" ]; then
  ls -1t $BACKUP_PATTERN 2>/dev/null | tail -n +$((MAX_BACKUPS + 1)) | while read -r f; do
    rm -f "$f"
  done
fi
