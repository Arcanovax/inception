#!/bin/sh
mkdir -p /run/wordpress
chown -R www-data:www-data /var/www/html
echo "Starting INIT WordPress..."
echo "$DB_NAME"
echo "$DB_USER"
echo "$DB_USER_PASSWORD"

if [ ! -f wp-config.php ]; then
    echo "Config WordPress..."
    wp config create \
        --dbname="$DB_NAME" \
        --dbuser="$DB_USER" \
        --dbpass="$DB_USER_PASSWORD" \
        --dbhost="mariadb:3306" \
        --allow-root
fi

if ! wp core is-installed --allow-root; then
    echo "Installing WordPress..."
    wp core install \
    --url="$DOMAIN_NAME" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL"  \
    --skip-email \
    --allow-root
fi

echo "Starting WordPress..."
exec /usr/sbin/php-fpm8.2 -F