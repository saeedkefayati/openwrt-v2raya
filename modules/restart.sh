#!/bin/sh
#========================================
# restart.sh - Restart V2rayA Service
#========================================


restart_v2raya() {
    info "Restarting V2rayA service..."
    v2raya_service restart
    sleep 3
}

