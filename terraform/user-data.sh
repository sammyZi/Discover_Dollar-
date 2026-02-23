#!/bin/bash
set -e

# Update system packages
apt-get update
apt-get upgrade -y

# Install Docker using get.docker.com script
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
rm get-docker.sh

# Add ubuntu user to docker group
usermod -aG docker ubuntu

# Install Docker Compose from GitHub releases
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)
curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Create application directory
mkdir -p /home/ubuntu/meanapp
chown ubuntu:ubuntu /home/ubuntu/meanapp

# Install curl and git utilities
apt-get install -y curl git

echo "Setup complete"
