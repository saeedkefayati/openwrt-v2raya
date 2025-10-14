#!/bin/sh
#========================================
# stop.sh - Stop V2rayA Service
#========================================


stop_v2raya() {
    info "Stopping V2rayA service..."
    v2raya_service stop
    sleep 3
}

