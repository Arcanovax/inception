mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

DATADIR="/var/lib/mysql"
mkdir -p "$DATADIR"
chown mysql:mysql "$DATADIR"

if [ ! -d "$DATADIR/mysql" ]; then
    echo "Init of Mariadb"
    mariadb-install-db --user=mysql --datadir="$DATADIR"
fi

exec mariadbd --user=mysql --datadir="$DATADIR" --console
