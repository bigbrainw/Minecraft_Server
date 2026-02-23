#!/bin/bash
# Install systemd services for auto-start on boot
# Minecraft (Docker) + playit.gg

set -e
cd "$(dirname "$0")"

echo "Installing auto-start services..."

# Use current user if not root
INSTALL_USER="${SUDO_USER:-$USER}"
SCRIPT_DIR="$(pwd)"

# Update service files with actual paths (minecraft runs as root for Docker access)
sed -e "s|/home/elijah/Downloads/Minecraft_Server|$SCRIPT_DIR|g" \
    minecraft.service > /tmp/minecraft.service
sudo cp /tmp/minecraft.service /etc/systemd/system/
rm -f /tmp/minecraft.service

sudo systemctl daemon-reload
sudo systemctl enable docker.service
sudo systemctl enable minecraft.service
sudo systemctl disable playit.service 2>/dev/null || true   # playit now in Docker

echo ""
echo "Done! Minecraft + playit (Docker) will start on next boot."
echo ""
echo "To start now (without reboot):"
echo "  sudo systemctl start minecraft"
echo ""
echo "To check status:"
echo "  sudo systemctl status minecraft"
echo "  sudo docker compose ps"
echo ""
