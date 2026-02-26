#!/bin/bash
# Download InventoryWizard - sort inventory/chest with double-click (hotbar) or Shift+Right Click
# Requires Paper server (not Vanilla). Place in plugins/ folder.
# https://hangar.papermc.io/VanishingTacos/InventoryWizard

set -e
cd "$(dirname "$0")"
mkdir -p plugins

PLUGIN_URL="https://hangarcdn.papermc.io/plugins/VanishingTacos/InventoryWizard/versions/1.1.1/PAPER/InventoryWizard-1.1.1.jar"
PLUGIN_JAR="plugins/InventoryWizard-1.1.1.jar"

echo "Downloading InventoryWizard..."
curl -L -o "$PLUGIN_JAR" "$PLUGIN_URL"

if [ -f "$PLUGIN_JAR" ]; then
    echo "Done: $PLUGIN_JAR"
    echo ""
    echo "Usage:"
    echo "  Hotbar:     Double-click any hotbar slot"
    echo "  Inventory:  Shift+Right Click in main inventory (slots 9-35)"
    echo "  Chest:      Shift+Right Click any slot in chest"
    echo ""
    echo "Restart server to load. Requires Paper (not Vanilla)."
else
    echo "Download failed!"
    exit 1
fi
