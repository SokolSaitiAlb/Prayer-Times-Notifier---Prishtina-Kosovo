# Quick Start Guide - Prayer Times Notifier ⚡

Get your prayer times notifier running in **5 minutes**!

## 🚀 Installation (3 Steps)

### Step 1: Install Dependencies

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install curl jq libnotify-bin
```

**Fedora/RHEL/CentOS:**
```bash
sudo dnf install curl jq libnotify
```

**Arch Linux/Manjaro/Cachy OS/Artix:**
```bash
sudo pacman -S curl jq libnotify
```

**NixOS:**
```bash
# Add to configuration.nix or use nix-shell
nix-shell -p curl jq libnotify
```

**Alpine Linux:**
```bash
apk add curl jq libnotify
```

**For KDE Plasma 6 (All distros):**
```bash
# Arch-based systems
sudo pacman -S kdialog

# Fedora/RHEL
sudo dnf install kdialog

# Debian/Ubuntu
sudo apt install kdialog
```

### Step 2: Clone & Setup

```bash
git clone https://github.com/SokolSaitiAlb/Prayer-Times-Notifier---Prishtina-Kosovo.git
cd Prayer-Times-Notifier---Prishtina-Kosovo
chmod +x prayer_times.sh
```

### Step 3: Run!

```bash
./prayer_times.sh
```

✅ You should see today's prayer times and a desktop notification!

---

## 📅 Setup Auto-Notifications (Optional)

### Option A: Check Every 5 Minutes

```bash
crontab -e
```

Add this line:
```
*/5 * * * * /full/path/to/prayer_times.sh
```

### Option B: Check Once Daily (at midnight)

```bash
crontab -e
```

Add this line:
```
0 0 * * * /full/path/to/prayer_times.sh
```

---

## 🔧 Customize (5-Second Edit)

Edit `prayer_times.sh` and change:

```bash
# Change these lines:
CITY="Prishtina"              # ← Your city
COUNTRY="Kosovo"              # ← Your country
METHOD=4                      # ← Prayer calculation method
TIMEZONE=2                    # ← Your timezone
```

**Find your timezone offset:**
```bash
date +%z  # Shows your current timezone offset
```

---

## ❓ Common Issues

| Issue | Fix |
|-------|-----|
| "jq: command not found" | `sudo apt install jq` |
| No notifications appear | `sudo apt install libnotify-bin` |
| Permission denied | `chmod +x prayer_times.sh` |
| Wrong prayer times | Check `TIMEZONE=` in script |

---

## 📖 Need More Help?

- Full documentation: [README.md](README.md)
- Issues/bugs: [GitHub Issues](https://github.com/yourusername/prayer-times-notifier/issues)
- Adhan API docs: [aladhan.com](https://aladhan.com/islamic-api)

---

## 📍 For Prishtina, Kosovo Users

**Default settings are already optimized for Prishtina!**

- Calculation Method: Muslim World League (Method 4) ✓
- Timezone: CEST (UTC+2) ✓
- City: Prishtina ✓
- Country: Kosovo ✓

Just run `./prayer_times.sh` and you're done!

---

**Next Steps:**
1. ✅ Run the script once to test
2. ✅ Set up a cron job for automatic notifications
3. ✅ (Optional) Customize timezone/method if needed
4. ✅ Enjoy prayer time reminders! 🕌

Happy praying! 📿
