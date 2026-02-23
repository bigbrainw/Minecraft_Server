#!/bin/bash
# Backup all world folders into a compressed archive
# Run with: sudo ./backup-worlds.sh  (Docker creates world files as root)
set -e
cd "$(dirname "$0")"
BACKUP_NAME="world-backup-$(date +%Y%m%d-%H%M%S).tar.gz"
echo "Creating $BACKUP_NAME ..."
tar -czvf "$BACKUP_NAME" world-2 world-2_nether world-2_the_end
chown $(logname):$(logname) "$BACKUP_NAME" 2>/dev/null || chown $SUDO_USER:$SUDO_USER "$BACKUP_NAME" 2>/dev/null || true
echo "Done: $BACKUP_NAME ($(ls -lh "$BACKUP_NAME" | awk '{print $5}'))"
