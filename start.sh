#!/bin/bash
# Minecraft 1.21.11 Server - Start Script
# Optimized for Jetson Nano Super (8GB RAM)

set -e
cd "$(dirname "$0")"

SERVER_JAR="server.jar"
LOG_DIR="logs"

# Ensure server jar exists
if [ ! -f "$SERVER_JAR" ]; then
    echo "ERROR: $SERVER_JAR not found. Run ./download-server.sh first."
    exit 1
fi

# JVM settings for 8GB system - leave ~2GB for OS, playit, GPU on Jetson
# 6GB allocated to Minecraft server (was 5G to leave more headroom)
MEM_MIN="6G"
MEM_MAX="6G"

# Aikar's flags - optimized for Java 21 / G1GC
JAVA_OPTS="-Xms${MEM_MIN} -Xmx${MEM_MAX}"
JAVA_OPTS="$JAVA_OPTS -XX:+UseG1GC"
JAVA_OPTS="$JAVA_OPTS -XX:+ParallelRefProcEnabled"
JAVA_OPTS="$JAVA_OPTS -XX:MaxGCPauseMillis=200"
JAVA_OPTS="$JAVA_OPTS -XX:+UnlockExperimentalVMOptions"
JAVA_OPTS="$JAVA_OPTS -XX:+DisableExplicitGC"
JAVA_OPTS="$JAVA_OPTS -XX:+AlwaysPreTouch"
JAVA_OPTS="$JAVA_OPTS -XX:G1HeapWastePercent=5"
JAVA_OPTS="$JAVA_OPTS -XX:G1MixedGCCountTarget=4"
JAVA_OPTS="$JAVA_OPTS -XX:G1MixedGCLiveThresholdPercent=90"
JAVA_OPTS="$JAVA_OPTS -XX:G1RSetUpdatingPauseTimePercent=5"
JAVA_OPTS="$JAVA_OPTS -XX:SurvivorRatio=32"
JAVA_OPTS="$JAVA_OPTS -XX:+PerfDisableSharedMem"
JAVA_OPTS="$JAVA_OPTS -XX:MaxTenuringThreshold=1"
JAVA_OPTS="$JAVA_OPTS -Dusing.aikars.flags=https://mcflags.emc.gs"
JAVA_OPTS="$JAVA_OPTS -Daikars.new.flags=true"

# Optional: GC logging (uncomment for debugging)
# JAVA_OPTS="$JAVA_OPTS -Xlog:gc*:file=${LOG_DIR}/gc.log:time,uptime:filecount=5,filesize=1M"

echo "Starting Minecraft 1.21.11 server (allocated ${MEM_MAX})..."
exec java $JAVA_OPTS -jar "$SERVER_JAR" nogui
