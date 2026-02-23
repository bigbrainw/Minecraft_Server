# Minecraft Paper Server - Docker
# Supports aarch64 (Jetson) and amd64
FROM eclipse-temurin:21-jre-jammy

WORKDIR /server

# Aikar's JVM flags for Minecraft (same as start.sh)
ENV MEM_MIN="6G" \
    MEM_MAX="6G" \
    JAVA_OPTS="-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1"

# Use bash for signal handling (stop command)
RUN apt-get update && apt-get install -y --no-install-recommends \
    dumb-init \
    && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

# Expose Minecraft port
EXPOSE 25565

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/docker-entrypoint.sh"]
