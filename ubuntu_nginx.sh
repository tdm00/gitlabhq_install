# Installing nginx
sudo gem install passenger
sudo passenger-install-nginx-module

# Create nginx system account to run server
sudo adduser --system --no-create-home --disabled-login --disabled-password --group nginx

# Configure nginx to auto-start with the server
sudo wget -O init-deb.sh http://library.linode.com/assets/660-init-deb.sh
sudo mv init-deb.sh /etc/init.d/nginx
sudo chmod +x /etc/init.d/nginx
sudo /usr/sbin/update-rc.d -f nginx defaults

# Configure nginx server
sudo nano /opt/nginx/conf/nginx.conf

# Start nginx server
sudo /etc/init.d/nginx start


