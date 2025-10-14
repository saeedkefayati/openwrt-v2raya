#!/bin/sh
#========================================
# enable.sh - Enable Passwall Service
#========================================


enable_passwall() {
    info "Enabling V2rayA service..."
    passwall_service enable
    sleep 3
}

