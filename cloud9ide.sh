# Just in case NodeJS is already installed
yum erase nodejs npm
# Install required packages (hope I didn't miss something)
yum install git libxml2-devel libjpeg-devel python g++ make openssl-devel gcc-c++ gcc ruby ruby-devel rubygems tree
# FPM can be used to build custom package files for various Linux distributions
gem install fpm 
# Get Cloud9 from GitHub
git clone https://github.com/ajaxorg/cloud9.git
# Get and install latest Node.js 0.8.xx release, see http://nodejs.org/dist/
wget http://nodejs.org/dist/v0.8.25/node-v0.8.25.tar.gz
tar -xzf node-v0.8.25.tar.gz
cd node-v0.8.25
./configure --prefix=/usr/
make
mkdir /tmp/nodejs
make install DESTDIR=/tmp/nodejs/
# Create RPM file (for Red Hat / CentOS)
fpm -s dir -t rpm -n nodejs -v 0.8.25 -C /tmp/nodejs/ usr/bin usr/lib usr/share usr/include
rpm -ivh nodejs-0.8.25-1.x86_64.rpm
cd ../cloud9
# Latest stable version
git checkout v2.0.93
npm install -g sm
sm install
chown -R www-data:www-data .
cd ..
mv cloud9 /var/www
#su www-data
su root
# Run Web server and set /var/www as the base directory for the IDE
# The parameter -l 0.0.0.0 allows you to connect from hosts other than localhost (can be dangerous)
/var/www/cloud9/bin/cloud9.sh -w /var/www
