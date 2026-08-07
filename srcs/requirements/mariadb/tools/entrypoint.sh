#!/bin/sh
mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

DATADIR="/var/lib/mysql"
mkdir -p "$DATADIR"
chown mysql:mysql "$DATADIR"

mkdir -p /etc/mysql/mariadb.conf.d
cat > /etc/mysql/mariadb.conf.d/docker.cnf << EOF
[mysqld]
bind-address=0.0.0.0
port=3306
datadir=/var/lib/mysql
socket=/run/mysqld/mysqld.sock
skip-networking=0
EOF

if [ ! -d "$DATADIR/mysql" ]; then
    echo "Init MariaDB table system..."
    mariadb-install-db --user=mysql --datadir="$DATADIR"
fi


if [ ! -f "$DATADIR/.db_initialized" ]; then
	echo "Init MariaDB Inception table..."

    mariadbd --user=mysql --datadir="$DATADIR" --skip-networking=0 &
    pid=$!

    until mariadb -u root -e "SELECT 1" >/dev/null 2>&1; do
        echo "Waiting MariaDB..."
        sleep 1
    done

    echo "Creating SQL setup..."
    mariadb -u root <<-EOSQL
        USE mysql;
        CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
        CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
        FLUSH PRIVILEGES;
	EOSQL

    mariadb-admin -u root shutdown
    wait "$pid"

    touch "$DATADIR/.db_initialized"
else
	echo "Db already created"
fi

echo "Starting MariaDB..."
exec mariadbd --user=mysql --datadir="$DATADIR" --console
