#!/bin/bash

# 1. Environment & Locale Setup
export LC_ALL=en_US.UTF-8
PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# 2. Universal Location Autodetection
# Fetches City, Lat, and Lon based on your public IP
LOCATION_DATA=$(curl -s "http://ip-api.com/json/")
CITY=$(echo "$LOCATION_DATA" | jq -r '.city // "Unknown"')
LAT=$(echo "$LOCATION_DATA" | jq -r '.lat // "0"')
LON=$(echo "$LOCATION_DATA" | jq -r '.lon // "0"')

# 3. API URL Construction (Using Coordinates for better accuracy)
# Fallback to Prishtina if IP-API fails
if [ "$CITY" == "Unknown" ] || [ "$LAT" == "0" ]; then
    CITY="Prishtina (Fallback)"
    API_URL="http://api.aladhan.com/v1/timings/$(date +%d-%m-%Y)?latitude=42.6629&longitude=21.1655&method=4"
else
    API_URL="http://api.aladhan.com/v1/timings/$(date +%d-%m-%Y)?latitude=$LAT&longitude=$LON&method=4"
fi

# 4. Fetch Data
RESPONSE=$(curl -s "$API_URL")

# 5. Logic Fix: Check for Success (Code 200)
API_CODE=$(echo "$RESPONSE" | jq -r '.code')

if [ "$API_CODE" != "200" ]; then
    STATUS=$(echo "$RESPONSE" | jq -r '.status // "Connection Error"')
    kdialog --title "Prayer Times Error" --passivepopup "API Failed: $STATUS" 5
    exit 1
fi

# 6. Extract Timings
TIMINGS=$(echo "$RESPONSE" | jq -r '.data.timings')
FAJR=$(echo "$TIMINGS" | jq -r '.Fajr')
DHUHR=$(echo "$TIMINGS" | jq -r '.Dhuhr')
ASR=$(echo "$TIMINGS" | jq -r '.Asr')
MAGHRIB=$(echo "$TIMINGS" | jq -r '.Maghrib')
ISHA=$(echo "$TIMINGS" | jq -r '.Isha')

# 7. Output to Terminal
echo "------------------------------------"
echo "Location: $CITY"
echo "Date:     $(date +'%A, %d %B %Y')"
echo "------------------------------------"
echo "Fajr:     $FAJR"
echo "Dhuhr:    $DHUHR"
echo "Asr:      $ASR"
echo "Maghrib:  $MAGHRIB"
echo "Isha:     $ISHA"
echo "------------------------------------"

# 8. KDE Notification
MSG="Location: $CITY\nFajr: $FAJR\nDhuhr: $DHUHR\nAsr: $ASR\nMaghrib: $MAGHRIB\nIsha: $ISHA"
kdialog --title "Prayer Times" --msgbox "$MSG"
