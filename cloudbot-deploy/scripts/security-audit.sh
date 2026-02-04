#!/bin/bash
# ============================================
# Cloudbot Security Audit Script
# ============================================
# Run this script to check security configuration
# Usage: ./security-audit.sh
# ============================================

set -uo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

PASS="${GREEN}[PASS]${NC}"
FAIL="${RED}[FAIL]${NC}"
WARN="${YELLOW}[WARN]${NC}"
INFO="${BLUE}[INFO]${NC}"

ISSUES=0
WARNINGS=0

check_pass() { echo -e "${PASS} $1"; }
check_fail() { echo -e "${FAIL} $1"; ((ISSUES++)); }
check_warn() { echo -e "${WARN} $1"; ((WARNINGS++)); }
check_info() { echo -e "${INFO} $1"; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "${SCRIPT_DIR}")"
ENV_FILE="${PROJECT_DIR}/.env"

echo "============================================"
echo "Cloudbot Security Audit"
echo "============================================"
echo ""

# ============================================
# 1. Environment File Checks
# ============================================
echo "=== Environment Configuration ==="

if [[ -f "${ENV_FILE}" ]]; then
    check_pass "Environment file exists"

    # Check file permissions
    PERMS=$(stat -c %a "${ENV_FILE}" 2>/dev/null || stat -f %OLp "${ENV_FILE}" 2>/dev/null)
    if [[ "${PERMS}" == "600" ]] || [[ "${PERMS}" == "400" ]]; then
        check_pass "Environment file permissions are secure (${PERMS})"
    else
        check_fail "Environment file permissions too open: ${PERMS} (should be 600)"
        echo "       Fix: chmod 600 ${ENV_FILE}"
    fi

    # Check for placeholder values
    if grep -q "CHANGE_THIS\|YOUR_\|XXXXXXX\|sk-ant-api03-XXXX\|sk-XXXX" "${ENV_FILE}"; then
        check_fail "Environment file contains placeholder values"
        echo "       Please update all placeholder values in .env"
    else
        check_pass "No obvious placeholder values detected"
    fi

    # Check code execution setting
    if grep -q "ENABLE_CODE_EXECUTION=true" "${ENV_FILE}"; then
        check_warn "Code execution is ENABLED - high security risk"
        echo "       Only enable if you fully understand the implications"
    else
        check_pass "Code execution is disabled"
    fi

    # Check Telegram whitelist
    if grep -q "TELEGRAM_ALLOWED_USERS=YOUR_\|TELEGRAM_ALLOWED_USERS=$" "${ENV_FILE}"; then
        check_fail "Telegram user whitelist not configured"
        echo "       CRITICAL: Anyone could control your bot!"
    else
        check_pass "Telegram user whitelist is configured"
    fi

    # Check web UI password
    if grep -q "WEB_UI_PASSWORD=CHANGE_THIS\|WEB_UI_PASSWORD=$" "${ENV_FILE}"; then
        check_fail "Web UI password not changed from default"
    else
        check_pass "Web UI password has been set"
    fi
else
    check_fail "Environment file not found: ${ENV_FILE}"
    echo "       Create it: cp .env.example .env"
fi

echo ""

# ============================================
# 2. System Security Checks
# ============================================
echo "=== System Security ==="

# Check if running as root
if [[ $EUID -eq 0 ]]; then
    check_fail "Running as root - use a dedicated user instead"
else
    check_pass "Running as non-root user: $(whoami)"
fi

# Check Docker group
if groups | grep -q docker; then
    check_pass "User is in docker group"
else
    check_warn "User not in docker group - may need sudo for docker"
fi

# Check UFW status
if command -v ufw &> /dev/null; then
    if sudo ufw status | grep -q "Status: active"; then
        check_pass "UFW firewall is active"

        # Check if port 3000 is exposed
        if sudo ufw status | grep -q "3000.*ALLOW.*Anywhere"; then
            check_fail "Port 3000 is exposed publicly"
            echo "       Use SSH tunnel instead: ssh -L 3000:localhost:3000 user@server"
        else
            check_pass "Port 3000 is not publicly exposed"
        fi
    else
        check_fail "UFW firewall is not active"
        echo "       Enable: sudo ufw enable"
    fi
else
    check_warn "UFW not installed - firewall status unknown"
fi

# Check fail2ban
if command -v fail2ban-client &> /dev/null; then
    if systemctl is-active --quiet fail2ban; then
        check_pass "Fail2Ban is running"
    else
        check_warn "Fail2Ban is installed but not running"
    fi
else
    check_warn "Fail2Ban not installed"
fi

echo ""

# ============================================
# 3. Docker Security Checks
# ============================================
echo "=== Docker Security ==="

if command -v docker &> /dev/null; then
    check_pass "Docker is installed"

    # Check if containers are running as root
    if docker ps -q | head -1 | xargs -I {} docker inspect {} --format '{{.Config.User}}' 2>/dev/null | grep -q "^$\|^root$"; then
        check_warn "Some containers may be running as root"
    else
        check_pass "Containers appear to run as non-root"
    fi

    # Check for exposed ports
    EXPOSED=$(docker ps --format "{{.Ports}}" | grep "0.0.0.0" | grep -v "127.0.0.1" || true)
    if [[ -n "${EXPOSED}" ]]; then
        check_warn "Some containers have ports exposed to all interfaces:"
        echo "       ${EXPOSED}"
    else
        check_pass "No containers exposing ports to all interfaces"
    fi
else
    check_info "Docker not installed"
fi

echo ""

# ============================================
# 4. File Permission Checks
# ============================================
echo "=== File Permissions ==="

# Check .env.example shouldn't have secrets
if [[ -f "${PROJECT_DIR}/.env.example" ]]; then
    if grep -q "sk-ant-api03-[a-zA-Z0-9]" "${PROJECT_DIR}/.env.example" || \
       grep -q "sk-[a-zA-Z0-9]{20}" "${PROJECT_DIR}/.env.example"; then
        check_fail "Real API keys found in .env.example!"
        echo "       This file may be committed to git - remove secrets immediately"
    else
        check_pass ".env.example contains no real secrets"
    fi
fi

# Check .gitignore
if [[ -f "${PROJECT_DIR}/.gitignore" ]]; then
    if grep -q "\.env$\|\.env\*" "${PROJECT_DIR}/.gitignore"; then
        check_pass ".env is in .gitignore"
    else
        check_fail ".env is NOT in .gitignore - secrets may be committed!"
    fi
else
    check_warn "No .gitignore file found"
fi

echo ""

# ============================================
# Summary
# ============================================
echo "============================================"
echo "Audit Summary"
echo "============================================"

if [[ ${ISSUES} -eq 0 ]] && [[ ${WARNINGS} -eq 0 ]]; then
    echo -e "${GREEN}All checks passed!${NC}"
elif [[ ${ISSUES} -eq 0 ]]; then
    echo -e "${YELLOW}${WARNINGS} warning(s) found - review recommended${NC}"
else
    echo -e "${RED}${ISSUES} issue(s) and ${WARNINGS} warning(s) found${NC}"
    echo "Please address the issues above before running in production"
fi

echo ""
exit ${ISSUES}
