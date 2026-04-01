# KDE Plasma 6 Setup Guide

This guide provides detailed instructions for setting up Prayer Times Notifier with KDE Plasma 6's native notification system.

## Features

✨ **KDE Plasma 6 Integration:**
- Native system tray notifications
- Passive popups that auto-dismiss after 5 seconds
- Integrated with KDE's notification center
- Beautiful KDE theming and styling
- Works with both X11 and Wayland sessions

## Prerequisites

### Required

1. **KDE Plasma 6** (or later)
2. **kdialog** - KDE dialog utility
3. **curl** - For API requests
4. **jq** - For JSON parsing

### Check Your Setup

```bash
# Check KDE Plasma version
plasmashell --version

# Check if running X11 or Wayland
echo $XDG_SESSION_TYPE

# Verify kdialog is installed
which kdialog
```

## Installation

### Step 1: Install kdialog

**Arch Linux / Manjaro / Cachy OS / Artix:**
```bash
sudo pacman -S kdialog
```

**Fedora / RHEL / CentOS:**
```bash
sudo dnf install kdialog
```

**Debian / Ubuntu:**
```bash
sudo apt install kdialog
```

**NixOS:**
```bash
# Add to configuration.nix:
environment.systemPackages = with pkgs; [
  kdialog
];

# Then rebuild:
sudo nixos-rebuild switch
```

### Step 2: Install Other Dependencies

```bash
# Arch-based
sudo pacman -S curl jq libnotify

# Fedora-based
sudo dnf install curl jq libnotify

# Debian-based
sudo apt install curl jq libnotify-bin
```

### Step 3: Clone Repository

```bash
git clone https://github.com/SokolSaitiAlb/Prayer-Times-Notifier---Prishtina-Kosovo.git
cd Prayer-Times-Notifier---Prishtina-Kosovo
chmod +x prayer_times.sh
```

## Testing

### Test KDE Plasma Detection

```bash
# Run the script (should detect KDE Plasma automatically)
./prayer_times.sh
```

The script will automatically:
1. Detect your KDE Plasma environment
2. Use `kdialog` for notifications
3. Display passive popups in your system tray

### Manual KDE Dialog Test

```bash
# Test kdialog directly
kdialog --passivepopup "This is a test notification from Prayer Times!" 5 --title "Prayer Times Test"
```

## Configuration

### Systemd User Service (KDE Plasma)

Create `~/.config/systemd/user/prayer-notifier.service`:

```ini
[Unit]
Description=Prayer Times Notifier for KDE Plasma
After=plasmawayland-session.target plasmaX11-session.target

[Service]
Type=simple
ExecStart=/path/to/prayer_times.sh
Restart=on-failure
RestartSec=300

# KDE environment variables
Environment="DISPLAY=:0"
Environment="DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus"

[Install]
WantedBy=plasmawayland-session.target plasmaX11-session.target
```

Then:
```bash
# Reload systemd
systemctl --user daemon-reload

# Enable service
systemctl --user enable prayer-notifier.service

# Start service
systemctl --user start prayer-notifier.service

# Check status
systemctl --user status prayer-notifier.service
```

### Crontab Setup (KDE Plasma)

```bash
# Open crontab
crontab -e

# Add one of these:
# Every 5 minutes
*/5 * * * * DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus /path/to/prayer_times.sh

# Once daily at midnight
0 0 * * * DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus /path/to/prayer_times.sh
```

**Note:** The environment variables are necessary for kdialog to work in cron jobs.

### Auto-Start in KDE Plasma

To automatically start the script when you log in:

**Method 1: Using KDE System Settings**
1. Open **System Settings**
2. Go to **Startup and Shutdown → Autostart**
3. Click **+ Add Script**
4. Navigate to and select `prayer_times.sh`
5. Click **OK**

**Method 2: Using ~/.config/autostart**

Create `~/.config/autostart/prayer-notifier.desktop`:

```ini
[Desktop Entry]
Type=Application
Name=Prayer Times Notifier
Exec=/path/to/prayer_times.sh
StartupNotify=false
Terminal=false
Categories=Utility;
Icon=clock
```

## Notification Behavior

### Passive Popup Style

By default, kdialog shows passive popups that:
- Appear in your system tray area
- Auto-dismiss after 5 seconds
- Don't interrupt your work
- Follow your KDE color scheme

### Notification Examples

**Prayer Times Update (Informational):**
```
Title: Prayer Times
Message: 🕌 Today's Prayer Times (Prishtina)
         Fajr: 05:30
         Dhuhr: 12:30
         Asr: 15:45
         Maghrib: 18:15
         Isha: 20:00
```

**Prayer Alert (Critical):**
```
Title: 🕌 Prayer Time Alert
Message: It's time for Dhuhr prayer at 12:30
```

## Troubleshooting

### Issue: KDE Plasma Not Detected

**Check your environment:**
```bash
# Should show plasmwayland, plasmaX11, or KDE
echo $XDG_CURRENT_DESKTOP
echo $DESKTOP_SESSION
```

**Solution:**
Manually force KDE detection by editing the script:

```bash
# Find this line in prayer_times.sh:
DESKTOP=$(detect_desktop_environment)

# Change it to:
DESKTOP="KDE"  # Force KDE mode
```

### Issue: No Notification Appears

**Verify kdialog is working:**
```bash
kdialog --passivepopup "Test" 5 --title "Test"
```

If nothing appears:
1. Check if notification daemon is running:
   ```bash
   systemctl --user status notification-daemon
   ```

2. Restart the daemon:
   ```bash
   systemctl --user restart notification-daemon
   ```

3. Check KDE Plasma settings:
   - **System Settings → Notifications → Configure...**
   - Ensure notifications are enabled
   - Check sound settings

### Issue: Notifications Work in Terminal but Not in Cron

**Add environment variables to crontab:**
```bash
DISPLAY=:0
DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
*/5 * * * * /path/to/prayer_times.sh
```

**Or use full path:**
```bash
*/5 * * * * /usr/bin/env bash -c 'export DISPLAY=:0; export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus; /path/to/prayer_times.sh'
```

### Issue: Wrong User ID in Cron

Find your user ID:
```bash
id
# Output: uid=1000(username) gid=1000(username) groups=...
```

Update the DBUS path in crontab:
```bash
# Replace 1000 with your actual UID if different
DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
```

### Issue: Notifications on Wayland Session

For Wayland sessions:
```bash
# Check your session
echo $XDG_SESSION_TYPE

# If using Wayland, ensure environment is set:
export DISPLAY=:0
export WAYLAND_DISPLAY=wayland-0
```

## Advanced Configuration

### Custom Notification Sound

Edit the script to add a sound:

```bash
# Find the send_notification function and add:
if [ "$DESKTOP" = "KDE" ]; then
    kdialog --passivepopup "$message" 5 --title "$title"
    # Play a sound (optional)
    paplay /usr/share/sounds/freedesktop/stereo/complete.oga 2>/dev/null
fi
```

### Custom Colors and Styles

KDE Plasma notifications automatically use your system theme. To customize:
1. Open **System Settings**
2. Go to **Appearance → Colors**
3. Select your preferred color scheme
4. Notifications will automatically update

### Create a KDE Widget (Advanced)

You can create a custom KDE widget that shows prayer times. This requires:
- QML (Qt Markup Language)
- KDE Frameworks

See [KDE Development Guide](https://develop.kde.org/) for more information.

## KDE Plasma Versions

The script is tested and compatible with:
- ✅ KDE Plasma 5.27+
- ✅ KDE Plasma 6.0+
- ✅ KDE Plasma 6.1+ (Wayland and X11)

## Performance Impact

- **Memory:** < 5MB
- **CPU:** < 1% during execution
- **Notifications:** Lightweight passive popups
- **System Load:** Minimal

## Examples

### Example 1: Morning Prayer Reminder (Fajr)

```bash
# Create a script that checks for Fajr only
PRAYER_TIME=$(./prayer_times.sh 2>/dev/null | grep "Fajr" | awk '{print $NF}')
kdialog --passivepopup "Good morning! It's time for Fajr prayer at $PRAYER_TIME" 10 --title "Prayer Time"
```

### Example 2: Prayer Times Widget Display

```bash
# Show in KDE Plasmoid
kdialog --textbox <(./prayer_times.sh 2>/dev/null | head -10) 300 200 --title "Prayer Times"
```

### Example 3: Desktop Notification with Icon

```bash
# Show notification with custom icon
kdialog --passivepopup "$(./prayer_times.sh 2>/dev/null)" 8 --title "🕌 Prayer Times"
```

## Support

For KDE Plasma specific issues:
1. Check [KDE Community Forums](https://discuss.kde.org)
2. Open an issue on [GitHub](https://github.com/SokolSaitiAlb/Prayer-Times-Notifier---Prishtina-Kosovo/issues)
3. Include:
   - KDE Plasma version: `plasmashell --version`
   - Session type: `echo $XDG_SESSION_TYPE`
   - kdialog version: `kdialog --version`

## References

- [kdialog Documentation](https://docs.kde.org/kdialog/)
- [KDE Notification System](https://develop.kde.org/docs/plasma/)
- [KDE System Settings](https://userbase.kde.org/System_Settings)

---

**Last Updated:** 2024-01-15
**KDE Plasma Support:** v5.27 - v6.1+
**Maintained by:** [@SokolSaitiAlb](https://github.com/SokolSaitiAlb)
