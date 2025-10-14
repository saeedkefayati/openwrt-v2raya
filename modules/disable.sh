#!/bin/sh
#========================================
# disable.sh - Disable V2rayA Service
#========================================


disable_passwall() {
    info "Disabling V2rayA service..."
    passwall_service disable
    sleep 3
}

