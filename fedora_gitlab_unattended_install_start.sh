#!/bin/bash

export RUBY_VERSION=ruby-1.9.2-p290
export RAILS_ENV=production 

yum install -y make openssh-clients gcc libxml2 libxml2-devel libxslt libxslt-devel python-devel wget readline-devel ncurses-devel gdbm-devel glibc-devel tcl-devel openssl-devel db4-devel byacc httpd gcc-c++ curl-devel openssl-devel zlib-devel httpd-devel apr-devel apr-util-devel gitolite sqlite-devel libicu-devel redis

sudo bash -s stable < <(curl -sk https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)

source /etc/profile.d/rvm.sh

rvm install $RUBY_VERSION

rvm use $RUBY_VERSION --default

gem update --system

gem install rails passenger rake bundler grit

adduser -r -m --shell /bin/bash --comment 'git version control' git
mkdir /home/git/.ssh
chown git:git -R /home/git/.ssh 

ssh-keygen -q -o -N '' -t rsa -f /home/git/.ssh/id_rsa


mkdir /var/www/.ssh

cp -f /home/git/.ssh/id_rsa /var/www/.ssh/ && chown apache:apache /var/www/.ssh/id_rsa && chmod 600 /var/www/.ssh/id_rsa

ssh-keyscan localhost >> /var/www/.ssh/known_hosts

chown apache:apache -R /var/www/.ssh

usermod -s /bin/bash -d /var/www/ -G git apache

sed -i 's/0077/0007/g' /usr/share/gitolite/conf/example.gitolite.rc

su - git -c "gl-setup -q /home/git/.ssh/id_rsa.pub"

chown -R git:git /home/git/

chmod 770 /home/git/repositories/

chmod 770 /home/git/

chmod 600 -R /home/git/.ssh/

chmod 700 /home/git/.ssh/

chmod 600 /home/git/.ssh/authorized_keys

curl http://python-distribute.org/distribute_setup.py | python

easy_install pip

cd /var/www && git clone git://github.com/gitlabhq/gitlabhq.git && cd /var/www/gitlabhq

pip install pygments

bundle install

rvm all do passenger-install-apache2-module -a

