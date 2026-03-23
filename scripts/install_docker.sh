#!/bin/bash

# Check if the OS is Linux
if [ "$(uname)" != "Linux" ]; then
    echo "ERROR: This script is designed for Ubuntu."
    echo "If you are on a Mac or Windows (without WSL), please install Docker Desktop manually."
    exit 1
fi

# Update and install prerequisites
sudo apt update
sudo apt install -y ca-certificates curl

# Set up the official Docker GPG key
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources using the modern DEB822 format
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

# Install Docker Engine and Compose
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Manage permissions so you don't need sudo for docker commands
sudo groupadd docker 2>/dev/null
sudo usermod -aG docker $USER



# Links this script with the file containing the aliases

# THE PERMANENT HOOK (Unique to Avra Njord)
# Finds the absolute path of the .host_aliases file to create a reliable link
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ALIAS_PATH="$SCRIPT_DIR/.host_aliases"

# Unique ID (ensures this project doesn't collide with future ones)
PROJECT_ID="# AVRA_NJORD_PROJECT_HOOK"
HOOK_COMMAND="source $ALIAS_PATH"

echo "Checking terminal hooks..."

# Search for the unique ID comment 
if ! grep -qF "$PROJECT_ID" ~/.bashrc; then
    # First time installation
    echo "" >> ~/.bashrc
    echo "$PROJECT_ID" >> ~/.bashrc
    echo "$HOOK_COMMAND" >> ~/.bashrc
    echo "Unique hook installed for AVRA Njord!"
else
    # Update the existing hook (if the folder was moved)
    # This finds the ID line, goes to the next line (n), and changes it (c)
    sed -i "/$PROJECT_ID/!b;n;c$HOOK_COMMAND" ~/.bashrc
    echo "AVRA Njord hook updated to current path: $SCRIPT_DIR"
fi


echo "-------------------------------------------------------"
echo "INSTALLATION COMPLETE!"
echo "IMPORTANT: You MUST log out and log back in (or restart)"
echo "for the permission changes to take effect."
echo "-------------------------------------------------------"
