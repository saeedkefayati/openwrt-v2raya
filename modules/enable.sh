#!/bin/sh
#========================================
# enable.sh - Enable V2rayA Service
#========================================


enable_v2raya() {
    info "Enabling V2rayA service..."
    v2raya_service enable
    sleep 3
}

