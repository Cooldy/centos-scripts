## update
yum update -y


### ADD EPEL
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

#### INSTALL APPs
yum update -y
yum install htop nload iftop iotop yum-utils  wget curl vim screen lftp  -y

### ADD REMIs
wget http://rpms.remirepo.net/RPM-GPG-KEY-remi
wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
rpm -i remi-release-7.rpm
yum --enablerepo=remi update


### DISABLE firewall
systemctl disable firewalld
systemctl stop firewalld

####DISABLE SELINUX
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

### TUNE CONFIG
echo "net.netfilter.nf_conntrack_max = 500000
net.core.somaxconn = 2048
vm.swappiness = 0" >> /etc/sysctl.conf
sysctl -p






### NGINX
wget http://nginx.org/keys/nginx_signing.key
wget http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
nginx_signing.key
rpm -i nginx-release-centos-7-0.el7.ngx.noarch.rpm



### MYSQL

wget http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
yum localinstall mysql-community-release-el7-5.noarch.rpm -y
yum-config-manager --disable mysql56-community -y
yum-config-manager --enable mysql57-community-dmr -y
yum update -y
yum install mysql-community-server -y

echo "sql_mode=''" » /etc/my.cnf
echo "default_password_lifetime=0" » /etc/my.cnf


### Install nginx
yum install nginx -y

### INSTALL DEV TOOLS
yum groupinstall "development tools" -y

#### install imagick
yum --enablerepo=remi install ImageMagick -y

#### install memcached
yum install --enablerepo=remi memcached memcached-devel libmemcached-devel zlib zlib-devel libevent  -y



#### nignx 
systemctl enable nginx
systemctl restart nginx


systemctl enable mysqld
systemctl restart memcached
systemctl enable memcached
systemctl restart memcached



#### INSTALL php
#yum --enablerepo=remi  install  php56-php php56-php-common php56-php-devel php56-php-fpm php56-php-gd php56-php-mbstring php56-php-mcrypt php56-php-mysqlnd php56-php-pear php56-php-xml php56-php-pecl-memcached php56-php-pecl-memcache php56-php-pecl-imagick php56-php-opcache -y


#### INSTALL php 7
yum install  php70-php php70-php-common php70-php-devel php70-php-fpm php70-php-gd php70-php-mbstring php70-php-mcrypt php70-php-mysqlnd php70-php-pear php70-php-xml php70-php-pecl-memcached php70-php-pecl-memcache php70-php-pecl-imagick php70-php-opcache php70-php-zip -y
mv /usr/bin/php70 /usr/bin/php


#temp password for mysql 
#sudo grep 'temporary password' /var/log/mysqld.log
#changing password for mysql
mysqladmin -u root -p'old' password 'new'


php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php
php -r "if (hash('SHA384', file_get_contents('composer-setup.php')) === 'fd26ce67e3b237fffd5e5544b45b0d92c41a4afe3e3f778e942e43ce6be197b9cdc7c251dcde6e2a52297ea269370680') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); }"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/bin/composer

#lumen 
#composer create-project --prefer-dist laravel/lumen lumen_proj

#laravel
#composer create-project --prefer-dist laravel/laravel laravel_proj
