#!/bin/sh
#========================================
# stop.sh - Stop V2rayA Service
#========================================


stop_passwall() {
    info "Stopping V2rayA service..."
    passwall_service stop
    sleep 3
}

