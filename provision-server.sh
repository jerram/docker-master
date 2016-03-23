#!/usr/bin/env bash
# https://waqaralamgir.wordpress.com/2014/09/30/setting-vagrant-with-yii-php/

MYSQL_PASS="password"

echo 'Set Mysql defaults...'
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password ${MYSQL_PASS}"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${MYSQL_PASS}"
export DEBIAN_FRONTEND=noninteractive

echo 'Linux Dependencies...'
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y       \
apache2                       \
bison                         \
build-essential               \
autoconf                      \
curl                          \
git-core                      \
libapache2-mod-php5           \
libcurl4-openssl-dev          \
libffi-dev                    \
libgdbm-dev                   \
libgdbm3                      \
libncurses5-dev               \
libreadline6-dev              \
libssl-dev                    \
libyaml-dev                   \
mysql-server-5.5              \
libmysqlclient-dev            \
php5-cli                      \
php5-curl                     \
php5-mcrypt                   \
php5-mysql                    \
php5-gd                       \
python-software-properties    \
vim                           \
libapache2-mod-proxy-html     \
zlib1g-dev

echo 'Setup unattended-upgrades file...'
# unattended version of sudo dpkg-reconfigure -plow unattended-upgrades
UPDATES=$(cat <<EOF
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
EOF
)
echo "${UPDATES}"  | sudo tee /etc/apt/apt.conf.d/20auto-upgrades

echo 'Importing time zone information into mysql'
mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -uroot -p${MYSQL_PASS} mysql

# Run this manually after verifying its ok to run and wont delete uncommitted files
# echo 'Configure webroot...'
# sudo rm -rf /var/www
# sudo ln -s `pwd` /var/www
# sudo chown www-data:www-data /var/www
# sudo chmod 775 /var/www
# sudo usermod -a -G www-data ubuntu

echo "ServerName `hostname`"  | sudo tee /etc/apache2/httpd.conf

echo 'Setup hosts file...'
VHOST=$(cat <<EOF
<VirtualHost *:*>
  ProxyPass / http://127.0.0.1:3000/
  ProxyPassReverse / http://127.0.0.1:3000/
</VirtualHost>
EOF
)
echo "${VHOST}"  | sudo tee /etc/apache2/sites-enabled/000-default.conf

echo 'Enable mod_rewrite...'
sudo a2enmod proxy proxy_http rewrite
sudo service apache2 restart
