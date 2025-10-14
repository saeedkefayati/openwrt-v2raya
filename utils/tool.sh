#!/bin/sh
#========================================
# Tool Helper Functions
#========================================


# -------------------------------
# Get OpenWrt Information
# -------------------------------
get_openwrt_info() {
    file="/etc/openwrt_release"

    
    [ -f "$file" ] || { echo "$file not found!"; return 1; }

    RELEASE=$(grep DISTRIB_RELEASE "$file" 2>/dev/null | cut -d"'" -f2)
    REVISION=$(grep DISTRIB_REVISION "$file" 2>/dev/null | cut -d"'" -f2)
    ARCH=$(grep DISTRIB_ARCH "$file" 2>/dev/null | cut -d"'" -f2)

    
    RELEASE_MAJOR=$(echo "$RELEASE" | cut -d'.' -f1,2)

    if [ -z "$RELEASE" ]; then
        RELEASE_TYPE="UNKNOWN"
    elif echo "$RELEASE" | grep -iq "snapshot"; then
        RELEASE_TYPE="SNAPSHOT"
    elif echo "$RELEASE" | grep -iq "rc"; then
        RELEASE_TYPE="RC"
    elif echo "$RELEASE" | grep -iq "beta"; then
        RELEASE_TYPE="BETA"
    else
        RELEASE_TYPE="STABLE"
    fi


    if [ -n "$RELEASE_MAJOR" ]; then
        BRANCH="openwrt-$RELEASE_MAJOR"
    else
        BRANCH="UNKNOWN"
    fi


    case "$ARCH" in
        *mips* ) ARCH_TYPE="MIPS" ;;
        *arm_cortex*|*arm_arm* ) ARCH_TYPE="ARM32" ;;
        *aarch64* ) ARCH_TYPE="ARM64" ;;
        *x86* ) ARCH_TYPE="x86" ;;
        *powerpc* ) ARCH_TYPE="PowerPC" ;;
        *riscv* ) ARCH_TYPE="RISC-V" ;;
        *loongarch* ) ARCH_TYPE="LoongArch" ;;
        * ) ARCH_TYPE="UNKNOWN" ;;
    esac


    export RELEASE_TYPE RELEASE RELEASE_MAJOR ARCH ARCH_TYPE REVISION BRANCH
}


# -------------------------------
# Show OpenWrt Information
# -------------------------------
show_openwrt_info() {
    show_centered_text "OpenWrt System Information"
    echo ""
    printf "%-12s : %b\n" "RELEASE_TYPE" "$RELEASE_TYPE"
    printf "%-12s : %b\n" "RELEASE" "$RELEASE"
    printf "%-12s : %b\n" "MAJOR" "$RELEASE_MAJOR"
    printf "%-12s : %b\n" "ARCH" "$ARCH"
    printf "%-12s : %b\n" "ARCH_TYPE" "$ARCH_TYPE"
    printf "%-12s : %b\n" "REVISION" "$REVISION"
    printf "%-12s : %b\n" "BRANCH" "$BRANCH"
    show_separator
}


# -------------------------------
# Show Core Status
# -------------------------------
show_core_status() {
    show_centered_text "Core Component Status"
    echo ""
    grep -E '^SERVICE_[0-9]+' "./config.cfg" | while IFS= read -r line; do
        value=$(echo "$line" | cut -d'=' -f2- | tr -d '"')
        name=$(echo "$value" | cut -d'|' -f1)
        path=$(echo "$value" | cut -d'|' -f2)

        if [ ! -x "$path" ]; then
            status="${RED}Not Installed${NC}"
        else
            if "$path" status >/dev/null 2>&1; then
                status="${GREEN}Running${NC}"
            else
                status="${YELLOW}Stopped${NC}"
            fi
        fi

        printf "%-12s : %b\n" "$name" "$status"
    done
    show_separator
}


# -------------------------------
# V2rayA Service Runner
# -------------------------------
v2raya_service() {
    action="$1" # 'start', 'stop', 'restart', etc.

    if ! [ -x "$V2RAYA_SERVICE_DIR" ]; then
        warn "V2rayA service not found!"
        return 1 
    fi

    if "$V2RAYA_SERVICE_DIR" "$action"; then
        success "V2rayA service '$action' command completed successfully."
        return 0
    else
        error "V2rayA service '$action' command failed."
        return 1
    fi
}


# -------------------------------
# V2rayA Add Feeds
# -------------------------------
add_v2raya_feeds() {
    [ -z "$RELEASE_MAJOR" ] && { error "RELEASE_MAJOR not set! Run get_openwrt_info first."; return 1; }
    [ -z "$ARCH" ] && { error "ARCH not set! Run get_openwrt_info first."; return 1; }
    [ -z "$RELEASE_TYPE" ] && { error "RELEASE_TYPE not set! Run get_openwrt_info first."; return 1; }

    FEED_NAME="v2raya"

    case "$RELEASE_TYPE" in
        SNAPSHOT|RC|BETA|STABLE)
            BASE_URL="https://downloads.sourceforge.net/project/v2raya/openwrt/$ARCH"
            ;;
        *)
            warn "Unknown RELEASE_TYPE, defaulting to releases path"
            BASE_URL="https://downloads.sourceforge.net/project/v2raya/openwrt/$ARCH"
            ;;
    esac

    info "Adding V2rayA repositories for $RELEASE_TYPE ($RELEASE_MAJOR/$ARCH)..."

    if grep -q "$FEED_NAME" "$CUSTOM_FEEDS_FILE" 2>/dev/null; then
        info "Feed $FEED_NAME already exists, skipping."
    else
        echo "src/gz $FEED_NAME $BASE_URL" >> "$CUSTOM_FEEDS_FILE"
        success "Added feed: $FEED_NAME"
    fi
}
