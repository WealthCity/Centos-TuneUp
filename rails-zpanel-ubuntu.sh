#!/bin/bash
# BASH SCRIPT TO SETUP ZPANEL & RAILS DEVELOPMENT ENVIRONMENT IN UBUNTU

curl -Ss https://raw.github.com/zpanel/installers/master/install/Ubuntu-12_04/10_1_1.sh | bash

echo "====================================================="
echo "Installing dependencies"
echo "====================================================="

sudo apt-get -y install apache2-dev apache2-mpm-worker apache2-threaded-dev autoconf automake bison build-essential curl git-core imagemagick libc6-dev libcurl4-openssl-dev libffi-dev libgdbm-dev libmysqlclient-dev libmysql-ruby libncurses5-dev libreadline6 libreadline6-dev libreadline-dev libsqlite3-0 libsqlite3-dev libssl-dev libtool libxml2-dev libxslt1-dev libxslt-dev libyaml-dev libaprutil1-dev ncurses-dev nodejs openssl postfix sqlite3 subversion zlib1g zlib1g-dev

echo "====================================================="
echo "Updating package"
echo "====================================================="

sudo apt-get update

echo "====================================================="
echo "Installing Mysql"
echo "====================================================="

sudo apt-get -y install mysql-server mysql-client

echo "====================================================="
echo "Installing RVM"
echo "====================================================="

curl -L https://get.rvm.io | bash -s stable
rvm autolibs rvm_pkg install openssl
source ~/.rvm/scripts/rvm
echo "source ~/.rvm/scripts/rvm" >> ~/.bashrc

echo "====================================================="
echo "Installing Ruby"
echo "====================================================="

rvm install 2.0.0-p353
rvm use 2.0.0-p353 --default

echo "====================================================="
echo "Installing Rails"
echo "====================================================="

gem install bundler rails rake --no-rdoc --no-ri
gem update
gem update --system

echo "====================================================="
echo "Installing Mysql gem"
echo "====================================================="

gem install mysql -- --with-mysql-config=/usr/lib/mysql/mysql_config

echo "====================================================="
echo "Installing Passenger"
echo "====================================================="

gem install passenger
passenger-install-apache2-module

service apache2 restart

echo "Installation Completed!"
