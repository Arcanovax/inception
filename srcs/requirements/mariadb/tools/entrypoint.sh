mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

mariadb-install-db --user=mysql --datadir="/run/mysql"

exec mariadbd --user=mysql --console
