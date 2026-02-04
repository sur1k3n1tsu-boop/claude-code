#!/bin/bash
# ============================================
# Install Cloudbot as Systemd Service
# ============================================
# Run as the cloudbot user (moldbot)
# Usage: ./install-service.sh
# ============================================

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "${SCRIPT_DIR}")"
SERVICE_FILE="${PROJECT_DIR}/systemd/cloudbot.service"
SYSTEMD_DIR="/etc/systemd/system"

# Check if service file exists
if [[ ! -f "${SERVICE_FILE}" ]]; then
    log_error "Service file not found: ${SERVICE_FILE}"
    exit 1
fi

log_info "Installing Cloudbot systemd service..."

# Copy service file
sudo cp "${SERVICE_FILE}" "${SYSTEMD_DIR}/cloudbot.service"

# Update WorkingDirectory in service file to match actual location
sudo sed -i "s|WorkingDirectory=.*|WorkingDirectory=${PROJECT_DIR}|g" "${SYSTEMD_DIR}/cloudbot.service"

# Update User/Group if different
CURRENT_USER=$(whoami)
sudo sed -i "s|User=.*|User=${CURRENT_USER}|g" "${SYSTEMD_DIR}/cloudbot.service"
sudo sed -i "s|Group=.*|Group=${CURRENT_USER}|g" "${SYSTEMD_DIR}/cloudbot.service"

# Update ReadWritePaths
sudo sed -i "s|ReadWritePaths=/home/moldbot/cloudbot|ReadWritePaths=${PROJECT_DIR}|g" "${SYSTEMD_DIR}/cloudbot.service"

# Reload systemd
sudo systemctl daemon-reload

# Enable service (start on boot)
sudo systemctl enable cloudbot

log_info "Service installed successfully!"
echo ""
echo "Available commands:"
echo "  Start:   sudo systemctl start cloudbot"
echo "  Stop:    sudo systemctl stop cloudbot"
echo "  Status:  sudo systemctl status cloudbot"
echo "  Logs:    journalctl -u cloudbot -f"
echo "  Restart: sudo systemctl restart cloudbot"
echo ""

# Ask if user wants to start now
read -p "Start the service now? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo systemctl start cloudbot
    sleep 2
    sudo systemctl status cloudbot --no-pager
fi
