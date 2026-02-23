# Fix: Can't Rejoin After Quitting (playit)

## Quick steps when reconnect fails

1. **Wait 30–60 seconds** – playit clears stale connections; reconnecting too soon can fail.
2. **Restart Minecraft client** – Fully quit and reopen Minecraft.
3. **Try the other tunnel** – If you have JPN and LOS, switch URLs.
4. **Try LAN** – Same network: connect to `10.0.0.43` to confirm the server works.
5. **Restart playit** – Stop (`Ctrl+C`) and run `./playit-gg` again to reset tunnel state.

## Server change

- `network-compression-threshold` set to 256 (vanilla default). Can help with tunnel stability.
- Restart server for it to apply: `docker compose restart minecraft`

## If it keeps happening

- Use LAN when on the same network (most reliable).
- Check your routing: http://ping.gl.ply.gg
- playit Discord: https://discord.gg/AXAbujx
