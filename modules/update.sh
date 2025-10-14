#!/bin/sh
#========================================
# update.sh - Update V2rayA
#========================================


update_passwall() {
    info "Updating package lists..."
    opkg update
    
    info "Updating V2rayA package..."
    if ! opkg install "$PASSWALL_PACKAGE"; then
        error "Update failed!"
        return 1
    fi

    info "Restarting V2rayA service after update..."
    passwall_service restart

    success "Update completed successfully!"
    sleep 3
}

