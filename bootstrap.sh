#!/bin/bash
config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
#Bombs out on any error
set +e

#Shows you each command and the result
set +x

# update and dist-upgrade to latest for all packages
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confnew" \
--force-yes -fuy dist-upgrade


#configure hostname to firstname.lastname substituting your first and last names
#set domain name to hack.local
echo 'coy-bifulco.hack.local' > /etc/hostname

#add 3 users, larry, moe, and curly -- disabled passwords for interactive login
#larry is a system account, and should have a shell of /bin/false
adduser larry
passwd -d larry
#moe is a sysadmin, and should be able to sudo without a password
adduser moe
adduser moe sudo
passwd -d moe
adduser curly --shell /bin/false
passwd -d curly

#set vim as the default editor for the system
sed -i 's/gedit/vim/' /usr/share/applications/defaults.list

#install ntpd in a client mode
apt-get install ntp
restrict default kod nomodify notrap nopeer noquery >> /etc/ntp.conf
restrict -6 default kod nomodify notrap nopeer noquery >> /etc/ntp.conf
#install dnsmasq as a dns cache client, make sure it respects the hosts file
#apt-get dnsmasq
#configure system to use the dns cache

#add 3 entries to the hosts file
#        127.0.1.1 ironman
#        127.0.1.2 hawkeye
#        127.0.1.3 hulk

echo 127.0.1.1 ironman >> /etc/hosts
echo 127.0.1.2 hawkeye >> /etc/hosts
echo 127.0.1.3 hulk  >>  /etc/hosts
#make sure dns is configured with a default search domain of hack.local

echo mysql-server-5.5 mysql-server/root_password  string qqq111 | sudo debconf-set-selections
echo mysql-server-5.5 mysql-server/root_password_again  string qqq111 | sudo debconf-set-selections
apt-get install mysql-server -y


#install ufw with a default deny policy, allowing port 22/TCP from anywhere
apt-get install ufw
sudo ufw allow 22/tcp
#Set the system timezone to UTC


#create a cron job for the root user that runs the command touch /root/hi every minute
#crontab -e
#Install the following packages
#        curl
apt-get install curl -y
#        git-core
apt-get install git-core -y
#        htop
apt-get install htop -y
#install nginx webserver and make it serve up the default web site
apt-get install nginx -y -y

# install redis-server and start it
apt-get install redis-server -y
#        tmux
apt-get install tmux -y
#        sysstat
apt-get install sysstat -y
#        unison
apt-get install unison -y
#        unzip
apt-get install unzip -y




#Create a 1GB sparse ext3 formatted block file and mount it via fstab to /mnt/VOL1, should mount on boot
#mke2fs -M /mnt/VOL1 -t ext3
#Create 3 1GB sparse block files, format them as physical volumes, add all to volume group named vg-awesome and create a logical volume using all space in group named lv-awesomer, format as ext4, mounted on /mnt/VOL2 via fstab
#lvm2
#Create 2 1GB sparse block files, create a Linux software raid device, mirrored over the files at md0

#RAID device should be mounted automatically at /mnt/VOL3

#set nofile system limit (ulimit) to unlimited for the root user

#write a list of the installed packages on the system to /root/inventory, file permissions 644
mkdir /root/inventory/
touch /root/inventory/dpkg
dpkg --get-selections >> /root/inventory/dpkg.txt
touch /root/test
