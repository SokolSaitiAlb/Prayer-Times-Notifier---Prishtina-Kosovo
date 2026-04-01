# Prayer Times Notifier - Prishtina, Kosovo 🕌

A lightweight bash script that fetches daily prayer times for Prishtina, Kosovo using the Adhan API and sends desktop notifications at each prayer time.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Bash](https://img.shields.io/badge/bash-5.0+-green.svg)
![Platform](https://img.shields.io/badge/platform-Linux-lightgrey.svg)
![KDE Plasma](https://img.shields.io/badge/KDE%20Plasma-6-blue.svg)

**Repository:** [github.com/SokolSaitiAlb/Prayer-Times-Notifier---Prishtina-Kosovo](https://github.com/SokolSaitiAlb/Prayer-Times-Notifier---Prishtina-Kosovo)

## Features

✨ **Core Features:**
- 🔔 Automatic desktop notifications at prayer times
- 🌍 Real-time prayer times from Adhan API
- ⚙️ Configurable prayer calculation methods
- 🕐 Support for multiple timezones
- 📋 Display all daily prayer times
- 🔄 Easy cron job integration for continuous monitoring
- 🎨 **Native KDE Plasma 6 support** with system tray notifications
- 🐧 Support for multiple Linux distributions (Arch, Fedora, Debian, etc.)

## Prerequisites

Before running this script, ensure you have the following installed:

| Package | Purpose | Installation |
|---------|---------|--------------|
| `curl` | Fetch data from API | Pre-installed on most systems |
| `jq` | Parse JSON responses | Distro-specific (see below) |
| `notify-send` OR `kdialog` | Desktop notifications | Distro-specific (see below) |

### 📦 Installation by Distribution

#### Ubuntu/Debian (& Derivatives)

```bash
sudo apt update
sudo apt install curl jq libnotify-bin
```

#### Fedora/RHEL/CentOS

```bash
sudo dnf install curl jq libnotify
```

#### Arch Linux

```bash
sudo pacman -S curl jq libnotify
```

#### Manjaro

```bash
sudo pacman -S curl jq libnotify
# Or using Manjaro's GUI package manager
```

#### Artix Linux

```bash
sudo pacman -S curl jq libnotify
```

#### Cachy OS

```bash
sudo pacman -S curl jq libnotify
```

#### NixOS

Add to your `configuration.nix`:

```nix
environment.systemPackages = with pkgs; [
  curl
  jq
  libnotify
];
```

Then rebuild:
```bash
sudo nixos-rebuild switch
```

Or use it directly:
```bash
nix-shell -p curl jq libnotify
```

#### Alpine Linux

```bash
apk add curl jq libnotify
```

#### OpenSUSE

```bash
sudo zypper install curl jq libnotify
```

### 🎨 KDE Plasma 6 Support

The script automatically detects KDE Plasma and uses the native notification system:

```bash
# For KDE Plasma 6, install:
sudo pacman -S kdialog  # Arch-based
sudo dnf install kdialog  # Fedora
sudo apt install kdialog  # Debian/Ubuntu
```

The script will use **kdialog** for KDE Plasma, providing native system tray notifications.

### macOS Users

```bash
brew install curl jq terminal-notifier
# Note: You'll need to modify the notification command for macOS
```

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/SokolSaitiAlb/Prayer-Times-Notifier---Prishtina-Kosovo.git
cd Prayer-Times-Notifier---Prishtina-Kosovo
```

### 2. Make Script Executable

```bash
chmod +x prayer_times.sh
```

### 3. Test the Script

```bash
./prayer_times.sh
```

You should see today's prayer times displayed in the terminal and a desktop notification.

## Quick Start Guide

### Basic Usage

```bash
./prayer_times.sh
```

This will:
1. Fetch today's prayer times for Prishtina, Kosovo
2. Display times in your terminal
3. Show a desktop notification with all prayer times

### Run Once a Day

```bash
# Add to your daily cron job
0 0 * * * /path/to/your/prayer_times.sh >> /tmp/prayer_times.log 2>&1
```

### Monitor Every 5 Minutes

```bash
# Open crontab editor
crontab -e

# Add this line:
*/5 * * * * /path/to/your/prayer_times.sh
```

### Set Alerts for Specific Prayer Times

```bash
# Modify the script to get a specific prayer time
./prayer_times.sh | grep "Fajr"
```

## Configuration

Edit the script to customize settings:

```bash
CITY="Prishtina"           # City name
COUNTRY="Kosovo"           # Country name
METHOD=4                   # Calculation method (see below)
TIMEZONE=2                 # Timezone offset (CEST = 2)
```

### Prayer Calculation Methods

| Method | Description |
|--------|-------------|
| 1 | Jafari |
| 2 | Karachi |
| 3 | Kemenag |
| 4 | **Muslim World League** (Default) |
| 5 | Isna |
| 7 | Al Awail |
| 8 | University of Islamic Sciences |
| 9 | Moramonth |
| 10 | University of Tehran |
| 11 | Shia Ithna Ashari |

### Timezone Offsets

| Timezone | Offset | Region |
|----------|--------|--------|
| GMT | 0 | Greenwich Mean Time |
| CET | 1 | Central European Time (Winter) |
| **CEST** | **2** | Central European Summer Time (Summer) |
| EET | 2 | Eastern European Time |
| EEST | 3 | Eastern European Summer Time |

## Usage Examples

### Example 1: Run and Log Output

```bash
./prayer_times.sh >> prayer_times.log
```

### Example 2: Change Prayer Method

Edit the script:
```bash
METHOD=2  # Switch to Karachi method
```

### Example 3: Systemd Service (Optional)

Create `/etc/systemd/system/prayer-notifier.service`:

```ini
[Unit]
Description=Prayer Times Notifier
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=your_username
ExecStart=/path/to/prayer_times.sh
Restart=on-failure
RestartSec=300

[Install]
WantedBy=multi-user.target
```

Enable and start:
```bash
sudo systemctl enable prayer-notifier.service
sudo systemctl start prayer-notifier.service
```

## Troubleshooting

### Issue: "command not found: jq"
**Solution:** Install jq for your distribution:
```bash
# Arch/Manjaro/Cachy OS/Artix
sudo pacman -S jq

# Fedora/RHEL
sudo dnf install jq

# Ubuntu/Debian
sudo apt install jq
```

### Issue: No notifications appearing
**Solution:** Check if notify-send or kdialog is installed:
```bash
# For GNOME/general Linux:
which notify-send
sudo apt install libnotify-bin  # or your distro's package

# For KDE Plasma:
which kdialog
sudo pacman -S kdialog  # Arch
sudo dnf install kdialog  # Fedora
```

### Issue: KDE Plasma notifications not showing in system tray
**Solution:** Ensure kdialog is installed and KDE Plasma is running:
```bash
# Check if KDE Plasma is running
echo $DESKTOP_SESSION
# Should show: plasmawayland or plasmaX11

# Install kdialog
sudo pacman -S kdialog  # Arch
sudo dnf install kdialog  # Fedora
```

### Issue: API connection failed
**Solution:** Check your internet connection and ensure the API is accessible:
```bash
curl -s "http://api.aladhan.com/v1/timingsByCity/01-01-2024?city=Prishtina&country=Kosovo&method=4&timezone=2"
```

### Issue: Wrong prayer times
**Solution:** Verify your timezone and calculation method:
```bash
date +%z  # Check your system timezone
```

### Issue: Permission denied
**Solution:** Make sure the script is executable:
```bash
chmod +x prayer_times.sh
```

### Issue: Distro-Specific Problems

**NixOS Users:**
```bash
# Use nix-shell environment
nix-shell -p curl jq libnotify

# Then run the script
./prayer_times.sh
```

**Fedora/RHEL Users:**
If notifications don't work, ensure libnotify is properly installed:
```bash
sudo dnf install libnotify
gsettings get org.freedesktop.Notifications paths
```

**Arch/Manjaro/Cachy OS Users:**
Ensure your notification daemon is running:
```bash
# Check if notification daemon is running
systemctl --user status notification-daemon
# or for KDE
systemctl --user status plasmashell
```

## Script Breakdown

```bash
# Fetch prayer times from API
curl -s "http://api.aladhan.com/v1/timingsByCity/..."

# Parse JSON response
jq '.data.timings'

# Send desktop notification
notify-send "Title" "Message"
```

## API Reference

**Endpoint:** `http://api.aladhan.com/v1/timingsByCity/{date}`

**Parameters:**
- `date` - Date in DD-MM-YYYY format
- `city` - City name
- `country` - Country name
- `method` - Calculation method (1-11)
- `timezone` - Timezone offset

**Response:**
```json
{
  "data": {
    "timings": {
      "Fajr": "05:30",
      "Sunrise": "06:45",
      "Dhuhr": "12:30",
      "Asr": "15:45",
      "Sunset": "18:15",
      "Maghrib": "18:15",
      "Isha": "20:00"
    }
  }
}
```

## Performance Notes

- ⚡ Lightweight and minimal resource usage
- 🌐 Single API call per execution
- 💾 No database or dependencies required
- ⏱️ Typical execution time: < 2 seconds

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Ideas for Contributions

- [ ] macOS compatibility (use `terminal-notifier` instead of `notify-send`)
- [ ] Multiple city support
- [ ] Voice notifications
- [ ] Prayer time calendar generation
- [ ] Web interface
- [ ] Email notifications

## Known Limitations

- ⚠️ Requires active internet connection
- ⚠️ Adhan API may have rate limiting
- ⚠️ Linux-specific (notify-send). macOS users need modification
- ⚠️ No daylight-saving time auto-adjustment

## Future Roadmap

- [ ] Support for Windows (WSL)
- [ ] macOS native notifications
- [ ] Quranic ayah with each notification
- [ ] Prayer time calendar export (ICS format)
- [ ] Mobile app integration
- [ ] Hijri calendar support

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- 🙏 [Adhan API](https://aladhan.com/) for providing prayer times data
- 📚 Community contributions and feedback
- 🕌 Islamic community of Prishtina and Kosovo

## Support

If you encounter any issues or have questions:

1. Check the [Troubleshooting](#troubleshooting) section
2. Search [existing issues](https://github.com/SokolSaitiAlb/Prayer-Times-Notifier---Prishtina-Kosovo/issues)
3. Create a [new issue](https://github.com/SokolSaitiAlb/Prayer-Times-Notifier---Prishtina-Kosovo/issues/new) with:
   - Description of the problem
   - Output of `./prayer_times.sh`
   - Output of `uname -a`
   - Your Linux distribution (Arch, Fedora, Ubuntu, NixOS, Manjaro, etc.)
   - Installed versions of curl, jq, and notify-send/kdialog
   - Any error messages

**GitHub Repository:** [github.com/SokolSaitiAlb/Prayer-Times-Notifier---Prishtina-Kosovo](https://github.com/SokolSaitiAlb/Prayer-Times-Notifier---Prishtina-Kosovo)

## More Resources

- [Adhan API Documentation](https://aladhan.com/islamic-api)
- [Cron Job Guide](https://crontab.guru/)
- [Bash Scripting Guide](https://www.gnu.org/software/bash/manual/)
- [jq Manual](https://stedolan.github.io/jq/manual/)

---

**Made with ❤️ for the Muslim community of Prishtina, Kosovo**

⭐ If you find this useful, please consider giving it a star!
