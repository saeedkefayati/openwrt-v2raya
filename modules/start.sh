#!/bin/sh
#========================================
# start.sh - Start V2rayA Service
#========================================


start_passwall() {
    info "Starting V2rayA service..."
    passwall_service start
    sleep 3
}

