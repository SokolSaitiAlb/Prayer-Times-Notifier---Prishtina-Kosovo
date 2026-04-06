README content.
🕌 Universal Prayer Notifier (Linux)
A high-performance, auto-detecting Bash utility for Linux that fetches prayer times and sends native desktop notifications. Designed for DevOps engineers and Linux enthusiasts who want a "set it and forget it" solution.
✨ Features
 * 🌍 Auto-Location: Uses Geo-IP to automatically detect your City and Coordinates—no configuration needed.
 * 🚀 System-Wide Command: Install once and run prayer from any directory.
 * 🎨 KDE Plasma 6 & GNOME: Native support for kdialog and notify-send.
 * ⚙️ Modern Automation: Optimized for Systemd Timers (cleaner and more reliable than legacy Cron).
 * 🐧 Distro Agnostic: Tested on CachyOS, Arch, Fedora, and Ubuntu.
📦 Prerequisites
| Package | Purpose |
|---|---|
| curl | Fetch data from IP-API and Aladhan API |
| jq | Advanced JSON parsing |
| kdialog | Native KDE Plasma notifications (Recommended) |
| libnotify | Standard Linux notifications (Fallback) |
# Arch / CachyOS / Manjaro
sudo pacman -S curl jq kdialog libnotify

🛠️ Installation (System-Wide)
To move from a local script to a system-wide utility, follow these steps:
 * Clone & Enter:
   git clone https://github.com/SokolSaitiAlb/Prayer-Times-Notifier---Prishtina-Kosovo.git
cd Prayer-Times-Notifier---Prishtina-Kosovo

 * Install to Path:
   sudo cp prayer_times.sh /usr/local/bin/prayer
sudo chmod +x /usr/local/bin/prayer

 * Test it:
   prayer

🤖 Automation (Systemd Timer)
Forget Cron. Use a Systemd Timer for a more robust, modern Linux experience.
1. Create the Service
nano ~/.config/systemd/user/prayer-notifier.service
[Unit]
Description=Run Prayer Times Notifier
After=network-online.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/prayer
Environment=DISPLAY=:0
Environment=XDG_RUNTIME_DIR=/run/user/1000

2. Create the Timer
nano ~/.config/systemd/user/prayer-notifier.timer
[Unit]
Description=Check Prayer Times hourly

[Timer]
OnCalendar=hourly
Persistent=true

[Install]
WantedBy=timers.target

3. Enable
systemctl --user daemon-reload
systemctl --user enable --now prayer-notifier.timer

⚙️ Configuration
The script is zero-config by default, but you can edit /usr/local/bin/prayer to change the calculation method:
| Method ID | Authority |
|---|---|
| 4 | Muslim World League (Default) |
| 1 | Jafari |
| 3 | Kemenag |
| 5 | ISNA |
🧪 Troubleshooting
 * Locale Errors: If you see "ANSI_X3.4-1968" errors, the script automatically attempts to force en_US.UTF-8. Ensure your system has this locale generated.
 * Notification not showing: If running via Systemd, ensure the DISPLAY variable in the service file matches your echo $DISPLAY output (usually :0).
Made with ❤️ for the Global Muslim Community
⭐ If this tool helped your workflow, give it a star!
