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
echo "alias ll='ls -lah'" >> .bashrc
