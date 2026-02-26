#!/bin/bash
# Backup all world folders into a compressed archive
# If Docker created files as root: sudo ./backup-worlds.sh
# Or fix ownership first: sudo chown -R $USER:$USER world world_nether world_the_end 2>/dev/null
set -e
cd "$(dirname "$0")"
BACKUP_NAME="world-backup-$(date +%Y%m%d-%H%M%S).tar.gz"
# Include world + nether/end if they exist
WORLDS=(world world_nether world_the_end)
TO_BACKUP=()
for w in "${WORLDS[@]}"; do
  [ -d "$w" ] && TO_BACKUP+=("$w")
done
if [ ${#TO_BACKUP[@]} -eq 0 ]; then
  echo "No world folders found."
  exit 1
fi
echo "Creating $BACKUP_NAME (${TO_BACKUP[*]})..."
tar -czvf "$BACKUP_NAME" "${TO_BACKUP[@]}"
chown $(logname):$(logname) "$BACKUP_NAME" 2>/dev/null || chown ${SUDO_USER:-$USER}:${SUDO_USER:-$USER} "$BACKUP_NAME" 2>/dev/null || true
echo "Done: $BACKUP_NAME ($(ls -lh "$BACKUP_NAME" | awk '{print $5}'))"
