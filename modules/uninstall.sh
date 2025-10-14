#!/bin/sh
#========================================
# uninstall.sh - Uninstall V2rayA
#========================================

uninstall_passwall() {
    # Step 1: Stop the V2rayA service
    info "Stopping V2rayA service..."
    passwall_service stop

    # Step 2: Remove the V2rayA package
    info "Removing V2rayA package..."
    opkg remove "$PASSWALL_PACKAGE" >/dev/null 2>&1 || warn "Package not found or failed to remove."

    # Step 3: Remove feeds
    info "Removing V2rayA repositories..."
    FEEDS="passwall_packages passwall_luci"
    for feed in $FEEDS; do
        if grep -q "$feed" /etc/opkg/customfeeds.conf; then
            sed -i "/$feed/d" /etc/opkg/customfeeds.conf
            success "Removed feed: $feed"
        fi
    done

    # Step 4: Remove files and directories
    info "Removing custom script files..."
    [ -f "$PASSWALL_BIN_DIR" ] && rm -f "$PASSWALL_BIN_DIR" && success "Removed command: $PASSWALL_BIN_DIR"
    # info "Removing main script directory..."
    # [ -d "$PASSWALL_INSTALL_DIR" ] && rm -rf "$PASSWALL_INSTALL_DIR" && success "Removed directory: $PASSWALL_INSTALL_DIR"

    # Step 5: Update package lists
    info "Updating package lists..."
    opkg update

    success "V2rayA uninstalled successfully!"
    sleep 3
}