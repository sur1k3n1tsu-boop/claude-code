# Cloudbot Deploy

Configuration package for deploying a 24/7 AI agent on a VPS with Telegram integration.

## Quick Start

### Prerequisites

- Ubuntu 22.04+ VPS (2GB RAM minimum)
- SSH access with key-based authentication
- API key from Anthropic or OpenAI
- Telegram bot token from [@BotFather](https://t.me/BotFather)
- Your Telegram user ID from [@userinfobot](https://t.me/userinfobot)

### 1. VPS Setup (as root)

```bash
# Download and run setup script
curl -fsSL https://raw.githubusercontent.com/your-repo/cloudbot-deploy/main/scripts/setup-vps.sh | sudo bash
```

Or manually:

```bash
# Create dedicated user
adduser moldbot --disabled-password --gecos ""
usermod -aG sudo moldbot
echo "moldbot ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/moldbot

# Install Docker
curl -fsSL https://get.docker.com | sh
usermod -aG docker moldbot
```

### 2. Deploy (as moldbot user)

```bash
# Clone repository
git clone https://github.com/your-repo/cloudbot-deploy.git ~/cloudbot
cd ~/cloudbot

# Configure environment
cp .env.example .env
nano .env  # Fill in your API keys and Telegram token

# Start the bot
docker compose up -d
```

### 3. Install as System Service (optional)

```bash
./scripts/install-service.sh
```

## Configuration

### Environment Variables (.env)

| Variable | Description | Required |
|----------|-------------|----------|
| `ANTHROPIC_API_KEY` | Anthropic API key | Yes* |
| `OPENAI_API_KEY` | OpenAI API key | Yes* |
| `TELEGRAM_BOT_TOKEN` | Bot token from BotFather | Yes |
| `TELEGRAM_ALLOWED_USERS` | Comma-separated Telegram user IDs | Yes |
| `DEFAULT_MODEL` | Default LLM model | No |
| `ENABLE_CODE_EXECUTION` | Allow code execution (dangerous) | No |

*At least one API key required

### Security Configuration

1. **Never expose port 3000 publicly** - Use SSH tunnel:
   ```bash
   ssh -L 3000:localhost:3000 moldbot@your-vps-ip
   ```

2. **Always set TELEGRAM_ALLOWED_USERS** - Without this, anyone can control your bot

3. **Keep ENABLE_CODE_EXECUTION=false** unless you fully understand the risks

4. **Run security audit**:
   ```bash
   ./scripts/security-audit.sh
   ```

## Directory Structure

```
cloudbot-deploy/
├── docker-compose.yml      # Docker orchestration
├── Dockerfile              # Container image definition
├── .env.example            # Environment template
├── requirements.txt        # Python dependencies
├── config/
│   └── config.yaml.example # Application configuration
├── scripts/
│   ├── setup-vps.sh        # VPS initialization script
│   ├── install-service.sh  # Systemd service installer
│   └── security-audit.sh   # Security checker
└── systemd/
    └── cloudbot.service    # Systemd unit file
```

## Commands

```bash
# Start
docker compose up -d

# Stop
docker compose down

# View logs
docker compose logs -f

# Restart
docker compose restart

# Update
git pull && docker compose up -d --build
```

## Telegram Commands

| Command | Description |
|---------|-------------|
| `/start` | Initialize bot |
| `/help` | Show available commands |
| `/status` | Check bot status |
| `/clear` | Clear conversation history |

## Cost Estimation

Using GPT-4o-mini with default limits:
- ~100k tokens/day = ~$0.50/month
- VPS (Hetzner CX22): ~$5/month
- **Total: ~$6/month**

## Security Warnings

1. **Code Execution Risk**: If enabled, the agent can run arbitrary code on your server
2. **API Key Exposure**: Store `.env` securely, never commit to git
3. **Telegram Whitelist**: Without it, anyone can control your bot
4. **Conversation Logs**: May contain sensitive information

## Troubleshooting

### Bot not responding

```bash
# Check if container is running
docker compose ps

# View logs
docker compose logs cloudbot

# Restart
docker compose restart
```

### Permission denied

```bash
# Ensure user is in docker group
sudo usermod -aG docker $(whoami)
newgrp docker
```

### High token usage

1. Lower `MAX_TOKENS_PER_REQUEST` in `.env`
2. Set `DAILY_TOKEN_BUDGET` limit
3. Use `gpt-4o-mini` instead of `gpt-4o`
