#!/bin/bash

# Prayer Times Notifier for Prishtina
# Supports: GNOME, KDE Plasma 6, and other Linux desktop environments
# Requires: curl, jq, notify-send (or kdialog for KDE Plasma)

CITY="Prishtina"
COUNTRY="Kosovo"
METHOD=4 # Muslim World League method
TIMEZONE=2 # Central European Summer Time (CEST)

# Detect desktop environment
detect_desktop_environment() {
    if [ -n "$KDE_FULL_SESSION" ] || [ "$XDG_CURRENT_DESKTOP" = "KDE" ] || [ "$XDG_CURRENT_DESKTOP" = "plasmawayland" ] || [ "$XDG_CURRENT_DESKTOP" = "plasmaX11" ]; then
        echo "KDE"
    else
        echo "OTHER"
    fi
}

# Send notification based on desktop environment
send_notification() {
    local title=$1
    local message=$2
    local urgency=${3:-normal}
    
    DESKTOP=$(detect_desktop_environment)
    
    if [ "$DESKTOP" = "KDE" ]; then
        # Use kdialog for KDE Plasma
        if command -v kdialog &> /dev/null; then
            kdialog --passivepopup "$message" 5 --title "$title" 2>/dev/null
        else
            # Fallback to notify-send if kdialog is not available
            notify-send -u "$urgency" "$title" "$message"
        fi
    else
        # Use notify-send for GNOME and other desktops
        if command -v notify-send &> /dev/null; then
            notify-send -u "$urgency" "$title" "$message"
        else
            # Fallback: just print to stdout
            echo "$title: $message"
        fi
    fi
}

# Check if required commands are available
check_dependencies() {
    local missing_deps=0
    
    if ! command -v curl &> /dev/null; then
        echo "Error: curl is not installed. Please install curl."
        missing_deps=1
    fi
    
    if ! command -v jq &> /dev/null; then
        echo "Error: jq is not installed. Please install jq."
        missing_deps=1
    fi
    
    if ! command -v notify-send &> /dev/null && ! command -v kdialog &> /dev/null; then
        echo "Warning: Neither notify-send nor kdialog is installed."
        echo "Notifications will be printed to stdout instead."
    fi
    
    if [ $missing_deps -eq 1 ]; then
        exit 1
    fi
}

# Get current date in local time
TODAY=$(date +"%d-%m-%Y")

# API URL
API_URL="http://api.aladhan.com/v1/timingsByCity/$TODAY?city=$CITY&country=$COUNTRY&method=$METHOD&timezone=$TIMEZONE"

# Function to convert time to minutes since midnight
time_to_minutes() {
    local time=$1
    local hours=$(echo "$time" | cut -d':' -f1)
    local minutes=$(echo "$time" | cut -d':' -f2)
    echo $((hours * 60 + minutes))
}

# Check dependencies first
check_dependencies

# Get prayer times
response=$(curl -s "$API_URL")

# Check if API request was successful
if [ $? -ne 0 ] || [ -z "$response" ]; then
    send_notification "Prayer Times Error" "Failed to fetch prayer times from API" "critical"
    exit 1
fi

# Check for API errors in response
if echo "$response" | jq -e '.code' &> /dev/null; then
    error_msg=$(echo "$response" | jq -r '.status // .message // "Unknown error"')
    send_notification "Prayer Times Error" "API Error: $error_msg" "critical"
    exit 1
fi

# Extract prayer times
prayers=$(echo "$response" | jq -r '.data.timings')

if [ $? -ne 0 ] || [ -z "$prayers" ]; then
    send_notification "Prayer Times Error" "Failed to parse prayer times" "critical"
    exit 1
fi

# Current time in minutes
current_hour=$(date +"%H")
current_minute=$(date +"%M")
current_time=$((current_hour * 60 + current_minute))

# Prayer times array
declare -A prayer_times
prayer_times["Fajr"]=$(echo "$prayers" | jq -r '.Fajr')
prayer_times["Dhuhr"]=$(echo "$prayers" | jq -r '.Dhuhr')
prayer_times["Asr"]=$(echo "$prayers" | jq -r '.Asr')
prayer_times["Maghrib"]=$(echo "$prayers" | jq -r '.Maghrib')
prayer_times["Isha"]=$(echo "$prayers" | jq -r '.Isha')

# Display all prayer times in terminal
echo "==================================="
echo "Today's Prayer Times for Prishtina"
echo "==================================="
echo "Date: $(date '+%A, %B %d, %Y')"
echo ""
for prayer in "${!prayer_times[@]}"; do
    echo "$prayer:      ${prayer_times[$prayer]}"
done | sort
echo "==================================="

# Check if any prayer time is now or coming soon (within 1 minute)
prayer_alert_sent=false
for prayer in "${!prayer_times[@]}"; do
    prayer_time=${prayer_times[$prayer]}
    prayer_minutes=$(time_to_minutes "$prayer_time")
    
    # Check if prayer time is within the next minute
    if [ $prayer_minutes -ge $current_time ] && [ $prayer_minutes -lt $((current_time + 1)) ]; then
        send_notification "🕌 Prayer Time Alert" "It's time for $prayer prayer at $prayer_time" "critical"
        prayer_alert_sent=true
    fi
done

# Display notification with all prayer times (only if no specific prayer alert was sent)
if [ "$prayer_alert_sent" = false ]; then
    prayer_list="🕌 Today's Prayer Times (Prishtina)\n"
    prayer_list+="━━━━━━━━━━━━━━━━━━━━━\n"
    prayer_list+="Fajr:    ${prayer_times[Fajr]}\n"
    prayer_list+="Dhuhr:   ${prayer_times[Dhuhr]}\n"
    prayer_list+="Asr:     ${prayer_times[Asr]}\n"
    prayer_list+="Maghrib: ${prayer_times[Maghrib]}\n"
    prayer_list+="Isha:    ${prayer_times[Isha]}"
    
    send_notification "Prayer Times" "$prayer_list" "normal"
fi

echo ""
echo "Desktop Environment: $(detect_desktop_environment)"
echo "Notifications sent successfully!"
