#!/bin/bash
sudo -i
dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf update -y
## htop
dnf install -y htop
## end htop
## tmux
dnf install -y tmux
## end tmux
## nano
dnf install -y nano
## end nano
## wget
dnf install -y wget
## end wget
## wget
dnf install -y telnet
## end wget
## dig
dnf install -y bind-utils
## end dig
## neofetch
dnf install -y neofetch
## end neofetch
## Disable SELinux
setenforce 0
sed s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config > config && mv /etc/selinux/config /etc/selinux/config.bak && mv config /etc/selinux/
## end Disable SELinux
## apache
dnf install -y httpd
# echo '<!DOCTYPE html><html><h1>Sample</h1><br /><br /><h2>Other sample...server2</h2></html>' > /var/www/html/index.html
hostname -f >> /var/www/html/index.html
sed s/80/88/g /etc/httpd/conf/httpd.conf > httpd.conf && mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak && mv httpd.conf /etc/httpd/conf/
systemctl start httpd
systemctl enable httpd
## end apache
## SSH Config
sed -e s/\#GatewayPorts\ no/GatewayPorts\ yes/g -e s/\#AllowTcpForwarding/AllowTcpForwarding/g /etc/ssh/sshd_config > sshd_config && mv /etc/ssh/sshd_config /etc/ssh/sshd_config.bak && mv sshd_config /etc/ssh/
systemctl restart sshd
## end SSH Config
echo "alias ll='ls -lah'" >> /etc/profile
echo "neofetch" >> /etc/profile