#!/bin/bash
# BASH SCRIPT TO SETUP RAILS DEVELOPMENT ENVIRONMENT IN UBUNTU

echo "====================================================="
echo "Installing dependencies"
echo "====================================================="

sudo apt-get -y install apache2-dev apache2-mpm-worker apache2-threaded-dev autoconf automake bison build-essential curl git-core imagemagick libc6-dev libcurl4-openssl-dev libffi-dev libgdbm-dev libmysqlclient-dev libmysql-ruby libncurses5-dev libreadline6 libreadline6-dev libreadline-dev libsqlite3-0 libsqlite3-dev libssl-dev libtool libxml2-dev libxslt1-dev libxslt-dev libyaml-dev libaprutil1-dev ncurses-dev nodejs openssl postfix sqlite3 subversion zlib1g zlib1g-dev

echo "====================================================="
echo "Updating package"
echo "====================================================="

sudo apt-get update

echo "====================================================="
echo "Installing RVM & Ruby Latest-Stable"
echo "====================================================="

#\curl -sSL https://get.rvm.io | bash -s -- --autolibs=read-fail
#curl -L https://get.rvm.io | bash -s stable
\curl -sSL https://get.rvm.io | bash -s stable --ruby
source /usr/local/rvm/scripts/rvm
source ~/.rvm/scripts/rvm
echo "source ~/.rvm/scripts/rvm" >> ~/.bashrc

echo "====================================================="
echo "Installing Ruby"
echo "====================================================="

#rvm install 2.1.0
#rvm use 2.1.0 --default

echo "====================================================="
echo "Installing Rails"
echo "====================================================="

gem install bundler rails rake --no-rdoc --no-ri
gem update
gem update --system

echo "====================================================="
echo "Installing Mysql gem"
echo "====================================================="

#gem install mysql -- --with-mysql-config=/usr/lib/mysql/mysql_config
#gem install mysql -- --with-mysql-config=/usr/local/mysql/bin/mysql_config
gem install mysql2

echo "====================================================="
echo "Installing Passenger"
echo "====================================================="

gem install passenger
passenger-install-apache2-module

service apache2 restart

echo "Installation Completed!"

The Apache 2 module was successfully installed.

Please edit your Apache configuration file, and add these lines:

   LoadModule passenger_module /usr/local/rvm/gems/ruby-2.1.0/gems/passenger-4.0
   PassengerRoot /usr/local/rvm/gems/ruby-2.1.0/gems/passenger-4.0.33
   PassengerDefaultRuby /usr/local/rvm/wrappers/ruby-2.1.0/ruby

After you restart Apache, you are ready to deploy any number of web
applications on Apache, with a minimum amount of configuration!
