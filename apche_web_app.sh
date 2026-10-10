
#!/bin/bash

# Update package list
echo "Updating packages..."
sudo apt update

# Install Apache HTTP Server
echo "Installing Apache2..."
sudo apt install apache2 -y

# Start Apache service
echo "Starting Apache2 service..."
sudo systemctl start apache2

# Enable Apache at boot
echo "Enabling Apache2 at startup..."
sudo systemctl enable apache2

# Check service status
echo "Checking Apache2 status..."
sudo systemctl is-active apache2

# Display server IP
echo "Server IP address:"
hostname -I

echo "Apache2 installation completed!"
