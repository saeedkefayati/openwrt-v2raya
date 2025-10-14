#!/bin/sh
#========================================
# stop.sh - Stop Passwall Service
#========================================


stop_passwall() {
    info "Stopping V2rayA service..."
    passwall_service stop
    sleep 3
}

