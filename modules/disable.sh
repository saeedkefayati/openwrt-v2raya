#!/bin/sh
#========================================
# disable.sh - Disable V2rayA Service
#========================================


disable_v2raya() {
    info "Disabling V2rayA service..."
    v2raya_service disable
    sleep 3
}

