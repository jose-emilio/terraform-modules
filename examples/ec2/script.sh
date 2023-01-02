#!/bin/bash
yum update -y
yum install httpd -y
systemctl enable httpd
systemctl start httpd
echo "<h2>Soy una instancia EC2 y mi ID es $(curl http://169.254.169.254/latest/meta-data/instance-id)</h2>" > /var/www/html/index.html
