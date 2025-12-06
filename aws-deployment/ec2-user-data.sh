#!/bin/bash
# EC2 User Data Script for Documentation Analyzer
# This script runs automatically when EC2 instance launches

set -e

echo "Starting Documentation Analyzer deployment..."

# Update system
yum update -y

# Install Python 3.11 and dependencies
yum install -y python3.11 python3.11-pip git

# Install Playwright system dependencies
yum install -y nss atk at-spi2-atk cups-libs libdrm libxkbcommon \
    libxcomposite libxdamage libxfixes libxrandr libgbm libxshmfence alsa-lib

# Clone repository
cd /home/ec2-user
git clone https://github.com/Srishanthreddykatta/DocumentAnalysis.git
cd DocumentAnalysis/moengage_project/codebase

# Install Python dependencies
pip3.11 install -r requirements.txt

# Install Playwright browsers
playwright install chromium
playwright install-deps chromium

# Create systemd service file
cat > /etc/systemd/system/doc-analyzer.service << 'EOF'
[Unit]
Description=Documentation Analyzer Flask App
After=network.target

[Service]
Type=simple
User=ec2-user
WorkingDirectory=/home/ec2-user/DocumentAnalysis/moengage_project/codebase
Environment="GOOGLE_API_KEY="
Environment="PORT=5000"
ExecStart=/usr/bin/python3.11 app.py
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

# Set proper permissions
chown ec2-user:ec2-user -R /home/ec2-user/DocumentAnalysis

# Start service
systemctl daemon-reload
systemctl enable doc-analyzer
systemctl start doc-analyzer

# Wait a bit and check status
sleep 5
systemctl status doc-analyzer

echo "Deployment complete!"

