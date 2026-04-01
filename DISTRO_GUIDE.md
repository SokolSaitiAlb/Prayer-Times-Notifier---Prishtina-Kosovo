# Distribution-Specific Installation Guide

This guide provides detailed installation instructions for Prayer Times Notifier across various Linux distributions.

## Table of Contents

- [Ubuntu/Debian](#ubuntudebian)
- [Fedora/RHEL/CentOS](#fedorarhelcentos)
- [Arch Linux](#arch-linux)
- [Manjaro](#manjaro)
- [Cachy OS](#cachy-os)
- [Artix Linux](#artix-linux)
- [NixOS](#nixos)
- [Alpine Linux](#alpine-linux)
- [OpenSUSE](#opensuse)
- [Troubleshooting](#troubleshooting)

---

## Ubuntu/Debian

### Installation

```bash
# Update package lists
sudo apt update

# Install dependencies
sudo apt install curl jq libnotify-bin

# (Optional) For KDE Plasma 6
sudo apt install kdialog

# Clone and setup
git clone https://github.com/SokolSaitiAlb/Prayer-Times-Notifier---Prishtina-Kosovo.git
cd Prayer-Times-Notifier---Prishtina-Kosovo
chmod +x prayer_times.sh
```

### Verify Installation

```bash
./prayer_times.sh
```

### Add to Crontab

```bash
# Every 5 minutes
*/5 * * * * /path/to/prayer_times.sh

# Once daily at midnight
0 0 * * * /path/to/prayer_times.sh
```

---

## Fedora/RHEL/CentOS

### Installation

```bash
# Update package lists
sudo dnf update

# Install dependencies
sudo dnf install curl jq libnotify

# (Optional) For KDE Plasma 6
sudo dnf install kdialog

# Clone and setup
git clone https://github.com/SokolSaitiAlb/Prayer-Times-Notifier---Prishtina-Kosovo.git
cd Prayer-Times-Notifier---Prishtina-Kosovo
chmod +x prayer_times.sh
```

### Check Notification Daemon

```bash
# Verify notification daemon is running
systemctl --user status notification-daemon

# Start if not running
systemctl --user start notification-daemon
systemctl --user enable notification-daemon
```

### Add to Crontab

```bash
crontab -e

# Add one of these lines:
*/5 * * * * /path/to/prayer_times.sh
0 0 * * * /path/to/prayer_times.sh
```

---

## Arch Linux

### Installation

```bash
# Update package lists
sudo pacman -Syu

# Install dependencies
sudo pacman -S curl jq libnotify

# (Optional) For KDE Plasma 6
sudo pacman -S kdialog

# Clone and setup
git clone https://github.com/SokolSaitiAlb/Prayer-Times-Notifier---Prishtina-Kosovo.git
cd Prayer-Times-Notifier---Prishtina-Kosovo
chmod +x prayer_times.sh
```

### Check Notification Daemon

```bash
# For GNOME (using systemd user service)
systemctl --user status notification-daemon

# For KDE Plasma
systemctl --user status plasmashell
```

### Create Systemd Service (Optional)

```bash
# Create service file
sudo nano /etc/systemd/user/prayer-notifier.service
```

Paste this content:

```ini
[Unit]
Description=Prayer Times Notifier
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
ExecStart=/path/to/prayer_times.sh
Restart=on-failure
RestartSec=300

[Install]
WantedBy=multi-user.target
```

Then:

```bash
# Enable and start
systemctl --user enable prayer-notifier.service
systemctl --user start prayer-notifier.service

# Check status
systemctl --user status prayer-notifier.service
```

### Add to Crontab

```bash
crontab -e

# Add:
*/5 * * * * /path/to/prayer_times.sh
```

---

## Manjaro

### Installation

```bash
# Update package lists
sudo pacman -Syu

# Install dependencies
sudo pacman -S curl jq libnotify

# (Optional) For KDE Plasma 6
sudo pacman -S kdialog

# Clone and setup
git clone https://github.com/SokolSaitiAlb/Prayer-Times-Notifier---Prishtina-Kosovo.git
cd Prayer-Times-Notifier---Prishtina-Kosovo
chmod +x prayer_times.sh
```

### Test and Setup Crontab

```bash
# Test the script
./prayer_times.sh

# Add to crontab
crontab -e

# Add:
*/5 * * * * /path/to/prayer_times.sh
```

---

## Cachy OS

### Installation

```bash
# Update package lists
sudo pacman -Syu

# Install dependencies
sudo pacman -S curl jq libnotify

# (Optional) For KDE Plasma 6
sudo pacman -S kdialog

# Clone and setup
git clone https://github.com/SokolSaitiAlb/Prayer-Times-Notifier---Prishtina-Kosovo.git
cd Prayer-Times-Notifier---Prishtina-Kosovo
chmod +x prayer_times.sh
```

### Setup

```bash
# Test the script
./prayer_times.sh

# Add to crontab
crontab -e
*/5 * * * * /path/to/prayer_times.sh
```

---

## Artix Linux

### Installation

```bash
# Update package lists
sudo pacman -Syu

# Install dependencies (from community repo)
sudo pacman -S curl jq libnotify

# (Optional) For KDE Plasma 6
sudo pacman -S kdialog

# Clone and setup
git clone https://github.com/SokolSaitiAlb/Prayer-Times-Notifier---Prishtina-Kosovo.git
cd Prayer-Times-Notifier---Prishtina-Kosovo
chmod +x prayer_times.sh
```

### Using OpenRC (instead of systemd)

```bash
# Create rc-service file
sudo nano /etc/init.d/prayer-notifier
```

Paste:

```bash
#!/sbin/openrc-run

description="Prayer Times Notifier"
command="/path/to/prayer_times.sh"
pidfile="/var/run/prayer-notifier.pid"

depend() {
    need net
}

start() {
    ebegin "Starting Prayer Times Notifier"
    start-stop-daemon --start --background --exec $command
    eend $?
}

stop() {
    ebegin "Stopping Prayer Times Notifier"
    start-stop-daemon --stop --exec $command
    eend $?
}
```

Then:

```bash
sudo chmod +x /etc/init.d/prayer-notifier
sudo rc-service prayer-notifier start
```

Or use crontab:

```bash
crontab -e
*/5 * * * * /path/to/prayer_times.sh
```

---

## NixOS

### Installation (Temporary)

```bash
# Enter a temporary shell with dependencies
nix-shell -p curl jq libnotify

# Clone and setup
git clone https://github.com/SokolSaitiAlb/Prayer-Times-Notifier---Prishtina-Kosovo.git
cd Prayer-Times-Notifier---Prishtina-Kosovo
chmod +x prayer_times.sh

# Run the script
./prayer_times.sh
```

### Installation (Persistent)

Edit `/etc/nixos/configuration.nix`:

```nix
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl
    jq
    libnotify
  ];
  
  # Optional: Add kdialog for KDE Plasma
  # kde-frameworks.kdialog
}
```

Then:

```bash
sudo nixos-rebuild switch

# Clone and setup
git clone https://github.com/SokolSaitiAlb/Prayer-Times-Notifier---Prishtina-Kosovo.git
cd Prayer-Times-Notifier---Prishtina-Kosovo
chmod +x prayer_times.sh
./prayer_times.sh
```

### Using Crontab on NixOS

```bash
# Edit crontab
crontab -e

# Add:
*/5 * * * * /path/to/prayer_times.sh
```

---

## Alpine Linux

### Installation

```bash
# Update package lists
apk update

# Install dependencies
apk add curl jq libnotify

# Clone and setup
git clone https://github.com/SokolSaitiAlb/Prayer-Times-Notifier---Prishtina-Kosovo.git
cd Prayer-Times-Notifier---Prishtina-Kosovo
chmod +x prayer_times.sh
```

### Test and Setup

```bash
# Test the script
./prayer_times.sh

# Add to crontab
crontab -e

# Add:
*/5 * * * * /path/to/prayer_times.sh
```

---

## OpenSUSE

### Installation

```bash
# Update package lists
sudo zypper refresh

# Install dependencies
sudo zypper install curl jq libnotify

# (Optional) For KDE Plasma
sudo zypper install kdialog

# Clone and setup
git clone https://github.com/SokolSaitiAlb/Prayer-Times-Notifier---Prishtina-Kosovo.git
cd Prayer-Times-Notifier---Prishtina-Kosovo
chmod +x prayer_times.sh
```

### Test and Setup Crontab

```bash
# Test the script
./prayer_times.sh

# Add to crontab
crontab -e

# Add:
*/5 * * * * /path/to/prayer_times.sh
```

---

## Troubleshooting

### Issue: "command not found: curl"

**Arch-based:**
```bash
sudo pacman -S curl
```

**Fedora-based:**
```bash
sudo dnf install curl
```

**Debian-based:**
```bash
sudo apt install curl
```

### Issue: "command not found: jq"

**Arch-based:**
```bash
sudo pacman -S jq
```

**Fedora-based:**
```bash
sudo dnf install jq
```

**Debian-based:**
```bash
sudo apt install jq
```

### Issue: Notifications Not Working

```bash
# Check if notify-send is available
which notify-send

# Check if kdialog is available (for KDE)
which kdialog

# Ensure notification daemon is running
ps aux | grep notification-daemon
ps aux | grep plasmashell

# For KDE Plasma, restart the daemon
systemctl --user restart plasmashell
```

### Issue: Permission Denied

```bash
# Make script executable
chmod +x prayer_times.sh

# Verify
ls -la prayer_times.sh
# Should show: -rwxr-xr-x
```

### Issue: Crontab Not Working

```bash
# Verify crontab is installed
which crontab

# Check cron daemon is running
systemctl status cron  # Debian/Ubuntu
systemctl status crond  # Arch/Fedora

# Start if not running
sudo systemctl start cron

# Verify crontab entry
crontab -l
```

### Issue: API Connection Failed

```bash
# Test internet connection
ping -c 3 8.8.8.8

# Test API directly
curl "http://api.aladhan.com/v1/timingsByCity/01-01-2024?city=Prishtina&country=Kosovo&method=4&timezone=2"
```

---

## Support

For issues specific to your distribution, create an issue on GitHub:
[github.com/SokolSaitiAlb/Prayer-Times-Notifier---Prishtina-Kosovo/issues](https://github.com/SokolSaitiAlb/Prayer-Times-Notifier---Prishtina-Kosovo/issues)

Please include:
- Your Linux distribution and version (`uname -a`)
- Output of `./prayer_times.sh`
- Installed package versions (`curl --version`, `jq --version`)

---

**Last Updated:** 2024-01-15
**Maintained by:** [@SokolSaitiAlb](https://github.com/SokolSaitiAlb)
