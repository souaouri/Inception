#!/bin/bash

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

mv wp-cli.phar /usr/sbin/wp

cd /var/www/wordpress


# Uses wp-cli to download the WordPress core files into the current directory (/var/www/wordpress).
wp core download --allow-root
sleep 5

# Generates a wp-config.php file with the provided database details
wp core config --dbname=$db_name --dbuser=$db_user --dbpass=$db_pwd --dbhost=mariadb:3306 --allow-root

# wp core is-installed

wp core install --url=$domain_name --title="inception" --admin_user=$wp_admin_name --admin_password=$wp_admin_pwd --admin_email=$wp_user_email --allow-root

wp user create $wp_user_name $wp_user_email --role=$wp_user_role --allow-root


RUN chmod -R 777 /var/www


# Most web servers like Apache or Nginx (with PHP-FPM) run as the www-data user.
# If WordPress files are owned by root or some other user, the web server might not be able to read/write them, leading to: Errors loading the site ...
chown -R www-data:www-data /var/www/wordpress

# The web server needs to communicate with PHP-FPM over the network, not through the filesystem.
# In this case, nginx can't access the Unix socket inside the php-fpm container, so they must communicate via TCP on port 9000.
sed -i 's#listen = /run/php/php7.4-fpm.sock#listen = 0.0.0.0:9000#' /etc/php/7.4/fpm/pool.d/www.conf

# This is the full path to the PHP-FPM executable for PHP version 7.4.
# and -F tells PHP-FPM to run in the foreground (do not daemonize).
/usr/sbin/php-fpm7.4 -F
