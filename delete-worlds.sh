#!/bin/bash
# Delete all world folders (keeps backup archive)
# Run with: sudo ./delete-worlds.sh
set -e
cd "$(dirname "$0")"
echo "Deleting world-2, world-2_nether, world-2_the_end..."
rm -rf world-2 world-2_nether world-2_the_end
echo "Done. Backup preserved: $(ls world-backup-*.tar.gz 2>/dev/null || echo 'none')"
