#!/usr/bin/env bash
# provisioning for dev on vagrant requirements only
# https://gist.github.com/DaRaFF/3995789

# TODO this is for vagrant
# Remove /var/www default
sudo rm -rf /var/www/public
# Symlink /vagrant to /var/www
sudo ln -fs /vagrant /var/www/public

# Don't think these are needed
#apt-get install -y php-apc php-pear php5-xdebug php5 php5-devs
sudo apt-get install -y php5-xsl php5-intl

sudo mkdir /usr/share/adminer
sudo wget "http://www.adminer.org/latest.php" -O /usr/share/adminer/latest.php
sudo ln -s /usr/share/adminer/latest.php /usr/share/adminer/adminer.php
echo "Alias /adminer /usr/share/adminer/adminer.php" | sudo tee -a /etc/apache2/httpd.conf
# not available in apache 2.2
# sudo a2enconf adminer.conf
sudo service apache2 restart
