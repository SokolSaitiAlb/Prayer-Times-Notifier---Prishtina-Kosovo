 Final README.md
Update your GitHub README to this version. It removes the "Prishtina only" branding and targets a wider Linux audience.
# 🕌 Universal Prayer Notifier (Linux)

A lightweight, zero-config Bash utility for Linux that automatically detects your location and provides accurate prayer times via native desktop notifications.

![CachyOS](https://img.shields.io/badge/optimized_for-CachyOS-orange.svg)
![KDE Plasma](https://img.shields.io/badge/KDE%20Plasma-6-blue.svg)

## ✨ Features
- 🌍 **Auto-Location:** Uses Geo-IP to detect your city and coordinates instantly.
- 🚀 **System-Wide:** Install once and run `prayer` from any directory.
- 🎨 **KDE Plasma 6 Optimized:** Uses `kdialog` for non-intrusive passive popups.
- ⚙️ **DevOps Ready:** Built-in support for Systemd Timers and Path-based execution.

## 📦 Prerequisites
```bash
# Arch / CachyOS / Manjaro
sudo pacman -S curl jq kdialog libnotify

🛠️ Installation
 * Clone & Install:
   git clone [https://github.com/SokolSaitiAlb/Prayer-Times-Notifier---Prishtina-Kosovo.git](https://github.com/SokolSaitiAlb/Prayer-Times-Notifier---Prishtina-Kosovo.git)
cd Prayer-Times-Notifier---Prishtina-Kosovo
sudo cp prayer_times.sh /usr/local/bin/prayer
sudo chmod +x /usr/local/bin/prayer

 * Usage:
   Simply type prayer in your terminal.
🤖 Automation (Systemd)
Create ~/.config/systemd/user/prayer-notifier.timer:
[Timer]
OnCalendar=hourly
Persistent=true

Enable with: systemctl --user enable --now prayer-notifier.timer
Made with ❤️ for the Global Muslim Community

