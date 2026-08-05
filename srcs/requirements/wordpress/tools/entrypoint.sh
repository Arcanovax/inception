mkdir -p /run/wordpress
chown wordpress:wordpress /run/wordpress

DATADIR="/var/lib/wordpress"
mkdir -p "$DATADIR"
chown wordpress:wordpress "$DATADIR"

if [ ! -d "$DATADIR/wordpress" ]; then
    echo "Init of wordpress"
    # mariadb-install-db --user=mysql --datadir="$DATADIR"
fi

# exec mariadbd --user=mysql --datadir="$DATADIR" --console
