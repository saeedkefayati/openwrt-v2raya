#!/bin/sh
#========================================
# install.sh - Install V2rayA
#========================================

install_v2raya() {

    info "Checking required commands..."
    check_command opkg
    check_command wget
    check_command uci

    # Step 1: Add V2rayA GPG key
    info "Adding V2rayA GPG key..."
    if ! opkg-key list | grep -q v2raya; then
        wget -O /tmp/v2raya.pub https://master.dl.sourceforge.net/project/openwrt-v2raya-build/v2raya.pub
        opkg-key add /tmp/v2raya.pub
        rm /tmp/v2raya.pub
        success "GPG key added successfully."
    else
        info "GPG key already exists, skipping."
    fi

    # Step 2: Detect OpenWrt info
    info "Detecting OpenWrt release and architecture..."
    get_openwrt_info
    info "Detected OpenWrt $RELEASE_TYPE ($RELEASE) on $ARCH"

    # Step 3: Add V2rayA repositories
    info "Adding V2rayA repositories..."
    add_v2raya_feeds

    # Step 4: Update package lists
    info "Updating package lists..."
    opkg update || { error "Failed to update package lists"; return 1; }

    # Step 5: Install V2rayA
    info "Installing V2rayA..."
    if opkg list-installed | grep -q "$V2RAYA_PACKAGE"; then
        info "V2rayA already installed, skipping."
    else
        opkg install "$V2RAYA_PACKAGE" || { error "Failed to install V2rayA"; return 1; }
    fi

    # Step 6: Install Package Dependency Based On OS Version
    info "remove dnsmasq & install dnsmasq-full package"
    opkg remove dnsmasq
    opkg install dnsmasq-full


    info "Detecting firewall type to select correct dependencies..."
    if check_command "fw4"; then
        info "Modern (fw4/nftables) system detected. Setting backend to nftables."
        uci set v2raya.@global[0].firewall_backend='nftables'
        FIREWALL_DEPS="$MODERN_DEPS"
    else
        info "Legacy (fw3/iptables) system detected. Setting backend to iptables."
        uci set v2raya.@global[0].firewall_backend='iptables'
        FIREWALL_DEPS="$LEGACY_DEPS"
    fi

    ALL_DEPS="$COMMON_DEPS $FIREWALL_DEPS"
    opkg install $ALL_DEPS;
    success "Install firewall type to select correct dependencies..."


    # Step 7: Enable and start service
    info "Enabling V2rayA service settings..."
    uci set v2raya.@global[0].enabled='1'
    uci commit v2raya
    
    info "Enabling service on boot..."
    v2raya_service enable

    info "Stopping service to apply new settings..."
    v2raya_service stop
    sleep 2

    info "Starting service with new settings..."
    v2raya_service start

    success "V2rayA installation completed successfully!"
    sleep 3
}

