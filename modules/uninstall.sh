#!/bin/sh
#========================================
# uninstall.sh - Uninstall V2rayA
#========================================

uninstall_v2raya() {
    # Step 1: Stop and disable the V2rayA service
    info "Stopping and disabling V2rayA service..."
    v2raya_service stop
    v2raya_service disable

    # Step 2: Remove the V2rayA package
    info "Removing V2rayA package..."
    opkg remove "$V2RAYA_PACKAGE" >/dev/null 2>&1 || warn "Package not found or failed to remove."

    # Step 3: Cleanup leftover files and configurations
    info "Cleaning up leftover files and configurations..."

    info "Removing V2rayA repositories..."
    if grep -q "$FEED_NAME" "$CUSTOM_FEEDS_FILE"; then
        sed -i "/$FEED_NAME/d" "$CUSTOM_FEEDS_FILE"
        success "Removed feed: $FEED_NAME"
    fi
    
    # Step 4: Remove files and directories
    info "Removing V2rayA files and directories..."
    [ -f "$V2RAYA_BIN_DIR" ] && rm -f "$V2RAYA_BIN_DIR" && success "Removed command: $V2RAYA_BIN_DIR"
    
    # Remove the service script file left by opkg
    [ -f "$V2RAYA_SERVICE_DIR" ] && rm -f "$V2RAYA_SERVICE_DIR" && success "Removed service script."
    
    # Remove the UCI config file
    [ -f "/etc/config/v2raya" ] && rm -f "/etc/config/v2raya" && success "Removed UCI config file."

    # Step 5: Update package lists
    info "Updating package lists..."
    opkg update

    success "V2rayA uninstalled successfully!"
    sleep 3
}