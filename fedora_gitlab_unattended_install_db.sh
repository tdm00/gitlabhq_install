#!/bin/bash

export RUBY_VERSION=ruby-1.9.2-p290
export RAILS_ENV=production 

cd /var/www/gitlabhq
source /etc/profile.d/rvm.sh
rvm all do rake db:setup
rvm all do rake db:seed_fu
