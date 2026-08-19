#!/bin/bash

# Install Java 21 and wget
sudo apt update -y
sudo apt install -y openjdk-21-jdk wget

# Verify Java
java -version

# Download Tomcat 9.0.121
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.121/bin/apache-tomcat-9.0.121.tar.gz

# Extract Tomcat
tar -zxvf apache-tomcat-9.0.121.tar.gz

# Configure Tomcat users
sed -i '56a\<role rolename="manager-gui"/>' apache-tomcat-9.0.121/conf/tomcat-users.xml

sed -i '57a\<role rolename="manager-script"/>' apache-tomcat-9.0.121/conf/tomcat-users.xml

sed -i '58a\<user username="tomcat" password="admin@123" roles="manager-gui,manager-script"/>' apache-tomcat-9.0.121/conf/tomcat-users.xml

sed -i '59a\</tomcat-users>' apache-tomcat-9.0.121/conf/tomcat-users.xml

# Configure Manager application
cat > apache-tomcat-9.0.121/webapps/manager/META-INF/context.xml <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<Context privileged="true">
</Context>
EOF

# Start Tomcat
sh apache-tomcat-9.0.121/bin/startup.sh

# Verify Tomcat
sleep 5
ps -ef | grep tomcat
