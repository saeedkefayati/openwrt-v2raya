#!/bin/sh
# =============================
# V2rayA Installer
# =============================

# ================================
# Variables
# ================================
REPO_URL="https://github.com/saeedkefayati/openwrt-v2raya.git"
V2RAYA_INSTALL_DIR="/root/free-internet/v2raya"
V2RAYA_BIN_DIR="/usr/bin/v2a"
V2RAYA_COMMAND="v2a"

# ================================
# Step 1: Clone or update repository
# ================================
if [ ! -d "$V2RAYA_INSTALL_DIR" ]; then
    echo "[INFO] Cloning V2rayA repository to $V2RAYA_INSTALL_DIR"
    git clone "$REPO_URL" "$V2RAYA_INSTALL_DIR" || { echo "[ERROR] Failed to clone repo"; exit 1; }
else
    echo "[INFO] Updating V2rayA repository at $V2RAYA_INSTALL_DIR"
    git -C "$V2RAYA_INSTALL_DIR" reset --hard
    git -C "$V2RAYA_INSTALL_DIR" clean -fd
    git -C "$V2RAYA_INSTALL_DIR" pull || { echo "[ERROR] Failed to update repo"; exit 1; }
fi

# ================================
# Step 2: Grant execute permissions
# ================================
cd "$V2RAYA_INSTALL_DIR" || exit
find "$V2RAYA_INSTALL_DIR" -type f -name "*.sh" -exec chmod +x {} \;

# ================================
# Step 3: Create CLI shortcut
# ================================
cat <<EOF > "$V2RAYA_BIN_DIR"
#!/bin/sh
REPO_DIR="$V2RAYA_INSTALL_DIR"
cd "\$REPO_DIR"
git pull
./main.sh
EOF
chmod +x "$V2RAYA_BIN_DIR"

echo "[INFO] Shortcut ready: run '$V2RAYA_COMMAND' from anywhere."

# ================================
# Step 4: Run main.sh
# ================================
echo "[INFO] Launching V2rayA..."
"$V2RAYA_INSTALL_DIR/main.sh"
