#!/bin/bash
# Download playit.gg agent - latest release from GitHub
# Supports: aarch64 (Jetson), amd64, armv7

set -e
cd "$(dirname "$0")"

VERSION="v0.17.1"
ARCH=$(uname -m)
case "$ARCH" in
  aarch64|arm64)  BINARY="playit-linux-aarch64" ;;
  x86_64|amd64)   BINARY="playit-linux-amd64" ;;
  armv7l|armhf)   BINARY="playit-linux-armv7" ;;
  *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

URL="https://github.com/playit-cloud/playit-agent/releases/download/${VERSION}/${BINARY}"
OUTPUT="playit-gg"

echo "Downloading playit $VERSION ($BINARY)..."
curl -sSL -o "$OUTPUT" "$URL"
chmod +x "$OUTPUT"

if [ -f "$OUTPUT" ]; then
  echo "Done: ./playit-gg"
  echo "Run: ./playit-gg  (opens claim URL on first run)"
else
  echo "Download failed!"
  exit 1
fi
