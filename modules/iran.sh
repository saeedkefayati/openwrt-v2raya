#!/bin/sh
#========================================
# iran.sh - IRAN V2rayA Service
# (Smart Core-Detecting & Overwriting Version)
#========================================

iran_v2raya() {
    info "Change IRAN V2rayA Rule..."

    info "Updating package lists..."
    opkg update
    
    info "Installing dependencies (wget-ssl)..."
    opkg install wget-ssl
        
    info "Detecting running v2raya core..."
    
    local CORE_PROCESS=""
    local TARGET_DIR=""
    
    CORE_PROCESS=$(ps w | grep -e "/usr/bin/xray" -e "/usr/bin/v2ray" | grep -v "grep")
    
    if echo "$CORE_PROCESS" | grep -q "/usr/bin/xray"; then
        info "Xray core detected."
        TARGET_DIR="/usr/share/xray"
        
    elif echo "$CORE_PROCESS" | grep -q "/usr/bin/v2ray"; then
        info "v2ray core detected."
        TARGET_DIR="/usr/share/v2ray"

    else
        error "ERROR: No running v2ray or xray core found!"
        warn "Please ensure v2raya service is running before executing this script."
        return 1
    fi
    
    info "Target directory set to: $TARGET_DIR"
    
    mkdir -p "$TARGET_DIR"

    info "Downloading geoip.dat (overwriting)..."
    wget -O "$TARGET_DIR/geoip.dat" https://raw.githubusercontent.com/Chocolate4U/Iran-v2ray-rules/release/geoip.dat
    if [ $? -ne 0 ]; then
        error "Failed to download geoip.dat"
        return 1
    fi

    info "Downloading geosite.dat (overwriting)..."
    wget -O "$TARGET_DIR/geosite.dat" https://raw.githubusercontent.com/Chocolate4U/Iran-v2ray-rules/release/geosite.dat
    if [ $? -ne 0 ]; then
        error "Failed to download geosite.dat"
        return 1
    fi
    
    success "IRAN Rules for $TARGET_DIR (overwrite) updated successfully."
    sleep 2

    info "Restarting v2raya service to apply changes."
    v2raya_service restart
    sleep 2

    warn "now open your v2raya ui interface & add these setting to active this iran rules"
    warn "open setting on your v2raya ui & check exactly like these setting below (very Important!)"

    # Transparent Proxy/System Proxy
    printf "%-12s : %b\n" "Transparent Proxy/System Proxy" "On: Traffic Splitting Mode is the Same as the Rule Port"
    printf "%-12s : %b\n" "Transparent Proxy/System Proxy" "IP Forward"

    printf "%-12s : %b\n" "Transparent Proxy/System Proxy Implementation" "tproxy"
    printf "%-12s : %b\n" "Traffic Splitting Mode of Rule Port" "RoutingA"
    printf "%-12s : %b\n" "Prevent DNS Spoofing" "Forward DNS Request"
    printf "%-12s : %b\n" "Special Mode" "Off"
    printf "%-12s : %b\n" "TCPFastOpen" "Keep Default"
    printf "%-12s : %b\n" "Sniffing" "Http + TLS + Quic"
    printf "%-12s : %b\n" "Multiplex" "Off"
    
    # Automatically Update Subscriptions
    printf "%-12s : %b\n" "Automatically Update Subscriptions" "Update Subscriptions Regularly (Unit: hour)"
    printf "%-12s : %b\n" "Automatically Update Subscriptions" "720"

    printf "%-12s : %b\n" "Mode when Update Subscriptions and GFWList" "Follows Transparent Proxy/System Proxy"

    show_separator
    show_centered_text "After checking settings, go to 'Setting' -> 'RoutingA' tab."
    show_centered_text "Copy ALL the rules below and paste them into the 'Custom Rules' box:"
    show_separator
    cat << "EOF"
    domain(geosite:category-ads-all) -> block
    domain(geosite:ads) -> block
    domain(geosite:nsfw) -> block
    domain(geosite:category-porn) -> block
    domain(geosite:cavporn)-> block
    domain(geosite:54647)-> block
    domain(geosite:anon-v)-> block
    domain(geosite:avmoo)-> block
    domain(geosite:bdsmhub)-> block
    domain(geosite:bilibili2)-> block
    domain(geosite:boboporn)-> block
    domain(geosite:bongacams)-> block
    domain(geosite:brazzers)-> block
    domain(geosite:camwhores)-> block
    domain(geosite:chatwhores)-> block
    domain(geosite:clips4sale)-> block
    domain(geosite:coomer)-> block
    domain(geosite:cuinc)-> block
    domain(geosite:digitalplayground)-> block
    domain(geosite:dmm-porn)-> block
    domain(geosite:hentaivn)-> block
    domain(geosite:hooligapps)-> block
    domain(geosite:japonx)-> block
    domain(geosite:javbus)-> block
    domain(geosite:javcc)-> block
    domain(geosite:javdb)-> block
    domain(geosite:javwide)-> block
    domain(geosite:johren)-> block
    domain(geosite:justav)-> block
    domain(geosite:konachan)-> block
    domain(geosite:lethalhardcore)-> block
    domain(geosite:lisiku)-> block
    domain(geosite:mindgeek)-> block
    domain(geosite:mindgeek-porn)-> block
    domain(geosite:missav)-> block
    domain(geosite:moxing)-> block
    domain(geosite:mydirtyhobby)-> block
    domain(geosite:netflav)-> block
    domain(geosite:nudevista)-> block
    domain(geosite:nutaku)-> block
    domain(geosite:playboy)-> block
    domain(geosite:pornhub)-> block
    domain(geosite:pornpros)-> block
    ip(geoip:malware) -> block
    domain(geosite:malware) -> block
    ip(geoip:phishing) -> block
    domain(geosite:phishing) -> block
    domain(geosite:cryptominers) -> block
    domain(geosite:category-public-tracker) -> block
    ip(geoip:private)-> direct
    domain(geosite:private)-> direct
    domain(geosite:ir)-> direct
    ip(geoip:ir)-> direct
    domain(geosite:category-ir)-> direct
    domain(geosite:category-bank-ir)-> direct
    domain(geosite:category-bourse-ir)-> direct
    domain(geosite:category-education-ir)-> direct
    domain(geosite:category-forums-ir)-> direct
    domain(geosite:category-gov-ir)-> direct
    domain(geosite:category-insurance-ir)-> direct
    domain(geosite:category-media-ir)-> direct
    domain(geosite:category-news-ir)-> direct
    domain(geosite:category-payment-ir)-> direct
    domain(geosite:category-scholar-ir)-> direct
    domain(geosite:category-social-media-ir)-> direct
    domain(geosite:category-tech-ir)-> direct
    domain(geosite:category-travel-ir)-> direct
    domain(geosite:category-dev)-> proxy
    default: proxy
EOF

    info "After pasting the rules, click 'Save & Apply'."
}
