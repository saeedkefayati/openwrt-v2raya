#!/bin/sh
#========================================
# uninstall.sh - Uninstall V2rayA
#========================================


uninstall_v2raya() {
    # Step 1: Stop the V2rayA service
    info "Stopping V2rayA service..."
    v2raya_service stop

    # Step 2: Remove the V2rayA package
    info "Removing V2rayA package..."
    opkg remove "$V2RAYA_PACKAGE" >/dev/null 2>&1 || warn "Package not found or failed to remove."

    # Step 3: Remove feeds
    info "Removing V2rayA repositories..."
    FEED_NAME="v2raya"
    if grep -q "$FEED_NAME" "$CUSTOM_FEEDS_FILE"; then
        sed -i "/$FEED_NAME/d" "$CUSTOM_FEEDS_FILE"
        success "Removed feed: $FEED_NAME"
    fi

    # Step 4: Remove files and directories
    info "Removing custom script files..."
    [ -f "$V2RAYA_BIN_DIR" ] && rm -f "$V2RAYA_BIN_DIR" && success "Removed command: $V2RAYA_BIN_DIR"
    # info "Removing main script directory..."
    # [ -d "$V2RAYA_INSTALL_DIR" ] && rm -rf "$V2RAYA_INSTALL_DIR" && success "Removed directory: $V2RAYA_INSTALL_DIR"

    # Step 5: Update package lists
    info "Updating package lists..."
    opkg update

    success "V2rayA uninstalled successfully!"
    sleep 3
}