# Setup VMware Tools on Ubuntu server
# Initiate the VMWare Tools installer on your physical host
sudo apt-get update -y
sudo apt-get dist-upgrade -y
sudo apt-get install dkms build-essential gcc linux-headers-$(uname -r) -y
sudo mkdir -p /media/cdrom
sudo mount /dev/cdrom /media/cdrom
cp /media/cdrom/VM* /tmp
sudo umount /media/cdrom
cd /tmp
tar -xzvf VMware*.gz
cd vmware-tools-distrib/
sudo ./vmware-install.pl -d
sudo apt-get autoremove -y
sudo shutdown -r now