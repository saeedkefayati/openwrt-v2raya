#!/bin/sh
#========================================
# start.sh - Start Passwall Service
#========================================


start_passwall() {
    info "Starting V2rayA service..."
    passwall_service start
    sleep 3
}

