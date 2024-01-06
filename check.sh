Invoke-RestMethod -Uri "https://api.telegram.org/bot6386868886:AAElDjoYmFUYmcq7txUv_OMxjlfhK4aaZzI/sendMessage" -Method POST -Body @{
    chat_id = "-4007007898"
    text = "Your Message Here"
}

https://api.telegram.org/bot6386868886:AAElDjoYmFUYmcq7txUv_OMxjlfhK4aaZzI/getUpdates




#!/bin/bash

# Ngrok endpoint to ping
NGROK_ENDPOINT="tcp://0.tcp.ap.ngrok.io:14410"

# Telegram bot token and chat ID
TELEGRAM_BOT_TOKEN="6386868886:AAElDjoYmFUYmcq7txUv_OMxjlfhK4aaZzI"
TELEGRAM_CHAT_ID="-4007007898"

# Function to send a ping
function pingNgrok {
    curl --silent --head --fail "$NGROK_ENDPOINT" > /dev/null
    return $?
}

# Function to send a Telegram notification
function sendTelegramNotification {
    local message="Ping failed at $(date)"

    curl -s \
        -X POST \
        https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage \
        -d text="$message" \
        -d chat_id=$TELEGRAM_CHAT_ID > /dev/null
}

# Infinite loop to ping every 15 minutes
while true; do
    pingNgrok

    if [ $? -eq 0 ]; then
        echo "Ping successful at $(date)"
    else
        echo "Ping failed at $(date)"
        sendTelegramNotification
    fi

    sleep 900  # Sleep for 15 minutes (900 seconds)
done
