#!/bin/bash
set -e

cd /server

if [ ! -f server.jar ]; then
    echo "ERROR: server.jar not found. Mount server files or run download-server.sh first."
    exit 1
fi

echo "Starting Minecraft server (allocated ${MEM_MAX})..."
exec java -Xms${MEM_MIN} -Xmx${MEM_MAX} ${JAVA_OPTS} -jar server.jar nogui
