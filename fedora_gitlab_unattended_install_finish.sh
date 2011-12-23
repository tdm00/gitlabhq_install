#!/bin/bash

export RUBY_VERSION=ruby-1.9.2-p290
export RAILS_ENV=production 

cd /var/www/gitlabhq

source /etc/profile.d/rvm.sh

export PASSENGER_VERSION=`find /usr/local/rvm/gems/$RUBY_VERSION/gems -type d -name "passenger*" | cut -d '-' -f 4`

echo -e "<VirtualHost *:80>\nServerName `hostname --fqdn`\nDocumentRoot /var/www/gitlabhq/public\n<Directory /var/www/gitlabhq/public>\nAllowOverride all\nOptions -MultiViews\n</Directory>\n</VirtualHost>" > /etc/httpd/conf.d/gitolite.conf

echo -e "LoadModule passenger_module /usr/local/rvm/gems/$RUBY_VERSION/gems/passenger-$PASSENGER_VERSION/ext/apache2/mod_passenger.so\n   PassengerRoot /usr/local/rvm/gems/$RUBY_VERSION/gems/passenger-3.0.11\nPassengerRuby /usr/local/rvm/wrappers/$RUBY_VERSION/ruby" >> /etc/httpd/conf/httpd.conf 


chown -R apache:apache /var/www/

chown apache:root -R /usr/local/rvm/gems/

chmod 770 /home/git/

setenforce 0

sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config

sed -i '/--dport 22/ a\-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT' /etc/sysconfig/iptables

chmod go-w /home/git/

service iptables restart

service httpd start
