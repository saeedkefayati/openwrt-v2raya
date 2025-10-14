#!/bin/sh
#========================================
# start.sh - Start V2rayA Service
#========================================


start_v2raya() {
    info "Starting V2rayA service..."
    v2raya_service start
    sleep 3
}

