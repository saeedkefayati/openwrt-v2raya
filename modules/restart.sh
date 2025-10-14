#!/bin/sh
#========================================
# restart.sh - Restart V2rayA Service
#========================================


restart_passwall() {
    info "Restarting V2rayA service..."
    passwall_service restart
    sleep 3
}

