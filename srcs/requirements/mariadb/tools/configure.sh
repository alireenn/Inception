#!/bin/bash

if [ ! -d "/run/mysqld" ]
then
    mkdir -p /run/mysqld
    chown -R mysql:mysql /run/mysqld
fi

if [ ! -d "/var/lib/mysql/$DATABASE_NAME" ]
then
    chown -R mysql:mysql /var/lib/mysql
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null
    tmp=mktemp

    if [ ! -f "$tmp" ]
    then
        return 1
    fi

    cat << EOF > $tmp
USE mysql; #usa il database sequel
FLUSH PRIVILEGES; #update dei permessi sul database
DELETE FROM mysql.user WHERE User=''; #cancella dalla tabella user lo user di default ''
DROP DATABASE test; #cancella la tabella test
DELETE FROM mysql.db WHERE Db='test'; #cancella dalla tabella db il database test
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1'); #cancella dalla tabella degli user il campo root quando l'indirizzo di provenienza non è il localhost

ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PWD'; #cambia password utente root da localhost

CREATE DATABASE $DATABASE_NAME DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE USER '$DATABASE_ADMIN'@'%' IDENTIFIED BY '$DATABASE_ADMIN_PWD';
GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$DATABASE_ADMIN'@'%';
FLUSH PRIVILEGES;
   

    /usr/bin/mysqld --user=mysql --bootstrap < $tmp
    rm -f $tmp
fi

sed -i 's/skip-networking/# skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf
sed -i "s/#bind-address=.*/bind-address=0.0.0.0/g" /etc/my.cnf.d/mariadb-server.cnf

echo "MariaDB starting"

exec /usr/bin/mysqld --user=mysql --console