#!/bin/bash

# $1: ID of the modem, modems can be listed with `mmcli -L`

e_gps() {
    # in this way, gps data is managed and pushed to D-BUS by ModemManager
    #mmcli -m $1 --location-enable-gps-raw --location-enable-gps-nmea
    
    # in this way, gps can be handled by gpsd
    mmcli -m "$1" --location-enable-gps-unmanaged
}

# e_gps "$1"

e_gps any
