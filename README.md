# Minecraft 1.21.11 Server

Paper Minecraft server (Mounts of Mayhem) with plugin support, configured for **Jetson Nano Super** with 8GB RAM.

**Plugins:**
- **TAB v5.5.0** — Shows ping/latency (ms) in the player tab list

## Prerequisites

- **Java 21** (required for Minecraft 1.21.11)
  ```bash
  # Check Java version
  java -version
  
  # Ubuntu/Debian: Install if needed
  sudo apt update
  sudo apt install openjdk-21-jdk
  ```

## Quick Start

1. **Download the server jar**
   ```bash
   chmod +x download-server.sh start.sh
   ./download-server.sh
   ```

2. **Accept the EULA**  
   Edit `eula.txt` and change `eula=false` to `eula=true`

3. **Start the server**
   ```bash
   ./start.sh
   ```

   First run generates the world and may take a few minutes.

## Configuration

- **Memory**: Default 5GB allocated (leaves ~3GB for OS/GPU on Jetson)
- **Port**: 25565 (default)
- Edit `server.properties` after first run to customize (world name, max players, etc.)

## Docker

```bash
# Build and run (Minecraft + playit)
docker compose up -d

# View logs
docker compose logs -f minecraft
docker compose logs -f playit

# Stop (saves world first)
docker compose down
```

Both Minecraft and playit.gg run in Docker. playit uses host network so it connects to localhost:25565 (Minecraft's published port).

### Auto-start on boot (Jetson)

```bash
./install-autostart.sh
```

Enables Minecraft (Docker) + playit.gg to start when the Jetson boots.

## Running Headless

To run in background with `screen`:
```bash
screen -S minecraft
./start.sh
# Detach: Ctrl+A, then D
# Reattach: screen -r minecraft
```

Or use `systemd` for production (create a service file).

## File Structure

```
Minecraft_Server/
├── download-server.sh   # Fetches official 1.21.11 server jar
├── start.sh             # Start script with optimized JVM flags
├── eula.txt             # Must accept before first run
├── server.jar           # Created by download-server.sh
├── server.properties    # Generated on first run
└── world/               # Generated on first run
```
