# 1. Update system package index and install prerequisites
sudo apt update && sudo apt upgrade -y
sudo apt install wget openjdk-17-jre-headless -y

# 2. Create the application directory and download Nexus
sudo mkdir -p /app && cd /app
sudo wget https://download.sonatype.com/nexus/3/nexus-3.97.3-01-linux-x86_64.tar.gz

# 3. Extract the archive and rename the directory
sudo tar -xvf nexus-3.97.3-01-linux-x86_64.tar.gz
sudo mv nexus-3.97.3-01 nexus

# 4. Create dedicated nexus system user and set ownership
sudo adduser --system --no-create-home --group nexus
sudo chown -R nexus:nexus /app/nexus
sudo chown -R nexus:nexus /app/sonatype-work

# 5. Configure Nexus to run as the 'nexus' user
sudo sed -i 's/^#run_as_user=""/run_as_user="nexus"/' /app/nexus/bin/nexus.rc

# 6. Create systemd service unit file
sudo tee /etc/systemd/system/nexus.service > /dev/null << 'EOL'
[Unit]
Description=Sonatype Nexus Repository Manager
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=nexus
Group=nexus
ExecStart=/app/nexus/bin/nexus start
ExecStop=/app/nexus/bin/nexus stop
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOL

# 7. Reload systemd, enable service, and start Nexus
sudo systemctl daemon-reload
sudo systemctl enable --now nexus
sudo systemctl status nexus
