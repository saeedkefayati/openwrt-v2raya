#!/bin/sh
#========================================
# enable.sh - Enable V2rayA Service
#========================================


enable_passwall() {
    info "Enabling V2rayA service..."
    passwall_service enable
    sleep 3
}

