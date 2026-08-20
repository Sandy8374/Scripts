#!/bin/bash

set -e

# Update packages
sudo apt update -y

# Install required packages
sudo apt install -y wget curl gnupg

# Add Trivy GPG key
sudo mkdir -p -m 755 /etc/apt/keyrings

curl -fsSL https://aquasecurity.github.io/trivy-repo/deb/public.key \
  | sudo gpg --dearmor -o /etc/apt/keyrings/trivy.gpg

# Add Trivy repository
echo "deb [signed-by=/etc/apt/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" \
  | sudo tee /etc/apt/sources.list.d/trivy.list

# Update repository
sudo apt update -y

# Install Trivy
sudo apt install -y trivy

# Verify installation
trivy --version
