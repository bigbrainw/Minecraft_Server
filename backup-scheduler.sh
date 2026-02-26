#!/bin/bash
# Runs backup every 24 hours in the background. Keeps only 3 most recent backups.
# Usage: nohup ./backup-scheduler.sh > backup-scheduler.log 2>&1 &
# Or: ./backup-scheduler.sh   (foreground, Ctrl+C to stop)

set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

MAX_BACKUPS=3
BACKUP_PATTERN="world-backup-*.tar.gz"

prune_old_backups() {
  local count
  count=$(ls -1 $BACKUP_PATTERN 2>/dev/null | wc -l)
  if [ "$count" -gt "$MAX_BACKUPS" ]; then
    # List oldest first, delete until we have MAX_BACKUPS
    ls -1t $BACKUP_PATTERN 2>/dev/null | tail -n +$((MAX_BACKUPS + 1)) | while read -r f; do
      echo "Pruning old backup: $f"
      rm -f "$f"
    done
  fi
}

echo "Backup scheduler started. Backing up every 24 hours, keeping $MAX_BACKUPS backups."
echo "Log: $(date -Iseconds)"

while true; do
  if [ -f "backup-worlds.sh" ]; then
    ./backup-worlds.sh
    prune_old_backups
  else
    echo "Error: backup-worlds.sh not found"
    exit 1
  fi
  echo "Next backup in 24 hours. Sleeping..."
  sleep 86400
done
