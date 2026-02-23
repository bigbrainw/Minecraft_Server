#!/bin/bash
# Download Minecraft 1.21.11 Vanilla Server (official Mojang)
# To revert to Paper: api.papermc.io/v2/projects/paper/versions/1.21.11/builds/69/downloads/paper-1.21.11-69.jar

set -e
cd "$(dirname "$0")"

VERSION="1.21.11"
# Vanilla server jar from Mojang CDN (hash from version manifest)
SERVER_URL="https://piston-data.mojang.com/v1/objects/64bb6d763bed0a9f1d632ec347938594144943ed/server.jar"
SERVER_JAR="server.jar"

echo "Downloading Vanilla $VERSION from Mojang..."
curl -L -o "$SERVER_JAR" "$SERVER_URL"

if [ -f "$SERVER_JAR" ]; then
    echo "Download complete: $SERVER_JAR (vanilla)"
    echo "Run ./start.sh or docker compose up -d (after accepting EULA)"
else
    echo "Download failed!"
    exit 1
fi
