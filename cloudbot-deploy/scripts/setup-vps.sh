#!/bin/bash
# ============================================
# Cloudbot VPS Setup Script
# ============================================
# Run as root on a fresh Ubuntu 22.04+ VPS
# Usage: curl -fsSL <url>/setup-vps.sh | sudo bash
# ============================================

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   log_error "This script must be run as root"
   exit 1
fi

# Configuration
CLOUDBOT_USER="moldbot"
CLOUDBOT_HOME="/home/${CLOUDBOT_USER}"
CLOUDBOT_DIR="${CLOUDBOT_HOME}/cloudbot"

log_info "Starting Cloudbot VPS setup..."

# ============================================
# 1. System Update
# ============================================
log_info "Updating system packages..."
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# ============================================
# 2. Install Dependencies
# ============================================
log_info "Installing required packages..."
apt-get install -y \
    curl \
    wget \
    git \
    ufw \
    fail2ban \
    htop \
    ncdu \
    unattended-upgrades \
    apt-listchanges

# ============================================
# 3. Create Dedicated User
# ============================================
log_info "Creating dedicated user: ${CLOUDBOT_USER}..."

if id "${CLOUDBOT_USER}" &>/dev/null; then
    log_warn "User ${CLOUDBOT_USER} already exists, skipping creation"
else
    adduser "${CLOUDBOT_USER}" --disabled-password --gecos "Cloudbot Service Account"
    usermod -aG sudo "${CLOUDBOT_USER}"

    # Allow sudo without password for service operations
    echo "${CLOUDBOT_USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${CLOUDBOT_USER}
    chmod 440 /etc/sudoers.d/${CLOUDBOT_USER}
fi

# ============================================
# 4. Copy SSH Keys
# ============================================
log_info "Setting up SSH keys for ${CLOUDBOT_USER}..."

mkdir -p "${CLOUDBOT_HOME}/.ssh"
if [[ -f /root/.ssh/authorized_keys ]]; then
    cp /root/.ssh/authorized_keys "${CLOUDBOT_HOME}/.ssh/"
fi
chown -R "${CLOUDBOT_USER}:${CLOUDBOT_USER}" "${CLOUDBOT_HOME}/.ssh"
chmod 700 "${CLOUDBOT_HOME}/.ssh"
chmod 600 "${CLOUDBOT_HOME}/.ssh/authorized_keys" 2>/dev/null || true

# ============================================
# 5. Install Docker
# ============================================
log_info "Installing Docker..."

if command -v docker &> /dev/null; then
    log_warn "Docker already installed, skipping"
else
    curl -fsSL https://get.docker.com | sh
fi

# Add user to docker group
usermod -aG docker "${CLOUDBOT_USER}"

# Enable and start Docker
systemctl enable docker
systemctl start docker

# Verify Docker installation
docker --version
log_info "Docker installed successfully"

# ============================================
# 6. Configure Firewall
# ============================================
log_info "Configuring UFW firewall..."

ufw default deny incoming
ufw default allow outgoing

# Allow SSH (CRITICAL - do before enabling)
ufw allow 22/tcp comment 'SSH'

# Allow HTTP/HTTPS if needed for webhooks
# ufw allow 80/tcp comment 'HTTP'
# ufw allow 443/tcp comment 'HTTPS'

# DO NOT expose port 3000 - use SSH tunnel instead
# ufw allow 3000/tcp  # NEVER DO THIS

# Enable firewall
echo "y" | ufw enable
ufw status verbose

# ============================================
# 7. Configure Fail2Ban
# ============================================
log_info "Configuring Fail2Ban..."

cat > /etc/fail2ban/jail.local << 'EOF'
[DEFAULT]
bantime = 3600
findtime = 600
maxretry = 5

[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 86400
EOF

systemctl enable fail2ban
systemctl restart fail2ban

# ============================================
# 8. Configure Automatic Updates
# ============================================
log_info "Configuring automatic security updates..."

cat > /etc/apt/apt.conf.d/20auto-upgrades << 'EOF'
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
APT::Periodic::AutocleanInterval "7";
EOF

# ============================================
# 9. Create Cloudbot Directory
# ============================================
log_info "Creating Cloudbot directory..."

mkdir -p "${CLOUDBOT_DIR}"
chown -R "${CLOUDBOT_USER}:${CLOUDBOT_USER}" "${CLOUDBOT_DIR}"

# ============================================
# 10. Summary
# ============================================
echo ""
echo "============================================"
log_info "VPS Setup Complete!"
echo "============================================"
echo ""
echo "Next steps:"
echo "1. Reconnect as: ssh ${CLOUDBOT_USER}@$(curl -s ifconfig.me)"
echo "2. Clone your cloudbot repo to: ${CLOUDBOT_DIR}"
echo "3. Copy .env.example to .env and configure"
echo "4. Run: docker compose up -d"
echo ""
echo "Security summary:"
echo "- Firewall enabled (only SSH allowed)"
echo "- Fail2Ban protecting SSH"
echo "- Automatic security updates enabled"
echo "- Docker installed for ${CLOUDBOT_USER}"
echo ""
log_warn "Remember: Access web UI via SSH tunnel, NOT direct port exposure"
echo "  ssh -L 3000:localhost:3000 ${CLOUDBOT_USER}@$(curl -s ifconfig.me)"
echo ""
