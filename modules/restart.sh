#!/bin/sh
#========================================
# restart.sh - Restart Passwall Service
#========================================


restart_passwall() {
    info "Restarting Passwall v1 service..."
    passwall_service restart
    sleep 3
}

