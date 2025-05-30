#!/bin/bash
yum update -y
amazon-linux-extras install nginx1 -y
echo "<h1>Hello from $(hostname) 🚀</h1>" > /usr/share/nginx/html/index.html
systemctl enable nginx
systemctl start nginx

## User Data Script (`userdata.sh`)

This script is executed when EC2 instances launch. It:

- Updates the system  
- Installs NGINX web server  
- Creates a simple HTML page showing the instance hostname  
- Starts and enables NGINX service

This automation enables the Auto Scaling Group to serve the webpage without manual setup.
