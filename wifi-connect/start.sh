#!/usr/bin/env bash

freq=${CHECK_CONN_FREQ:-120}
check_host="${CHECK_HOST:-1.1.1.1}"

sleep 15

while [[ true ]]; do
    if [[ $VERBOSE != false ]]; then echo "Checking internet connectivity ..."; fi
    wget --spider --no-check-certificate $check_host > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        if [[ $VERBOSE != false ]]; then echo $'Your device is already connected to the internet.\nSkipping setting up Wifi-Connect Access Point. Will check again in '$freq' seconds.'; fi        
    else
        if [[ $VERBOSE != false ]]; then echo $'Your device is not connected to the internet. Could not reach '$check_host'\nStarting up Wifi-Connect.\n Connect to the Access Point and configure the SSID and Passphrase for the network to connect to.'; fi        
        ./wifi-connect
    fi

    sleep $freq

done
