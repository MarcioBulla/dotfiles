# Plasma Bigscreen

This branch contains the Plasma Bigscreen-only configuration for the living-room session. It is intentionally kept separate from `main`.

## Runtime flow

1. SDDM starts `plasma-bigscreen-with-decky` through the custom Wayland session.
2. The launcher sets `PLASMA_PLATFORM=mediacenter` and starts `decky-bigscreen.service`.
3. Plasma Bigscreen starts in its own DBus session.
4. When `HDMI-A-1` becomes available, it becomes the primary output and `eDP-1` is disabled without forcing a display mode.
5. Decky stops when the Bigscreen session exits.

The Steam favorite only opens `steam://open/bigpicture`; it does not start Decky a second time.

## Install

Install the user files with the repository symlink installer, then install the system files as root:

```bash
sudo ./scripts/install-plasma-bigscreen-root.sh
```

Required Arch packages:

```text
plasma-bigscreen plasma-nm plasma-pa powerdevil
```

The Polkit rule only grants the local active user `marcio` permission to manage `decky-bigscreen.service`. The service itself runs as root because it has no `User=` directive.
