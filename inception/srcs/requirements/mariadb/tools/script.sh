#!/bin/bash

service mariadb start

sleep 3

mariadb <<< "
    CREATE DATABASE IF NOT EXISTS $db_name ;
    CREATE USER IF NOT EXISTS '$db_user'@'%' IDENTIFIED BY '$db_pwd' ;
    GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'%' ;
    alter user 'root'@'localhost' identified by '$root_pwd';
    FLUSH PRIVILEGES ;
"

# This shuts down the running MariaDB service cleanly using the root user.
# We need this because we started MariaDB earlier with service mariadb start, but now we want to restart it properly with custom settings (see next step).
mariadb-admin -u root -p"$root_pwd" shutdown

# It safely starts the MariaDB database server:
    # On port 3306,
    # Accepting connections from any IP address,
    # Using /var/lib/mysql as the location for database data.
mariadbd-safe --port="3306" --bind="0.0.0.0" --datadir="/var/lib/mysql"
