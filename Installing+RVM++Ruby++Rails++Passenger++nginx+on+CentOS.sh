#Steps to install RVM + Ruby 1.9.3 + Rails + nginx + Passenger on CentOS (tested on v5.5)

# Todo get up to date repo's

# Install git and curl, if not already installed
sudo yum install git
sudo yum install curl-devel

# Create the rvm group and add any users who will be using rvm to the group
sudo su -
groupadd rvm

# Start by adding the root user (required to install RVM)
usermod -a -G rvm root

# TODO No longer works, new method of install
# Install RVM (system wide)
sudo bash < <( curl -L http://bit.ly/rvm-install-system-wide ) 

# Add this line to the end of any user who needs access to RVM's .bash_profile
# this will add it to the end of the current user's profile 

echo '[[ -s "/usr/local/lib/rvm" ]] && . "/usr/local/lib/rvm"  # This loads RVM into a shell session.' >> ~/.bash_profile
source ~/.bash_profile 

type rvm | head -1 # should print 'rvm is a function'

# I ran this to install ruby dependencies, as per instructions in `rvm notes`
sudo yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel libyaml-devel libffi-devel openssl-devel

# Install Ruby 1.9.3
sudo rvm install 1.9.3

# Set the RVM default to 1.9.3
rvm --default use 1.9.3

ruby -v # should return the version of ruby we're using

# Now, install Rails and Passenger
gem install rails passenger

# Install nginx with Passenger support. Press 1 when prompted
rvmsudo passenger-install-nginx-module

# Set up a nginx init script -- I used the one found here: http://articles.slicehost.com/2009/2/2/centos-adding-an-nginx-init-script
# and modified the nginx and NGINX_CONF_FILE variables to point to my nginx install (which is in /opt/nginx)
cd /etc/init.d
sudo wget -O nginx http://bit.ly/8XU8Vl
sudo chmod +x nginx

# set nginx to start automatically when the server restarts
sudo /sbin/chkconfig nginx on

# the mysql gem requires mysql-devel
sudo yum install mysql-devel
gem install mysql

# the pg gem requires postgresql-devel
sudo yum install postgresql-devel
gem install pg

# Sources
# http://constantshift.com/rails-3-0-on-mt-media-temple-ve-server-rvm-nginx-passenger/
# http://articles.slicehost.com/2009/2/2/centos-adding-an-nginx-init-script
# http://rvm.beginrescueend.com/deployment/system-wide/ (also see the 'Commnunity Resources' links at the bottom of the page)
# http://rvm.beginrescueend.com/rvm/install/
# http://blog.blenderbox.com/2011/01/07/installing-rvm-ruby-rails-passenger-nginx-on-centos/
