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
sed s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config
## end Disable SELinux
echo "alias ll='ls -lah'" >> /etc/profile
echo "neofetch" >> /etc/profile