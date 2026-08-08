#!/bin/sh
mkdir -p /run/wordpress
chown -R www-data:www-data /var/www/html

until mysql -h mariadb -u$DB_USER -p$DB_PASSWORD -e "SELECT 1" > /dev/null 2>&1; do
	echo "Waiting MariaDB..."
    sleep 2
done

if [ ! -f wp-config.php ]; then
    echo "Creating a WordPress Configuration..."
    wp config create \
        --dbname="$DB_NAME" \
        --dbuser="$DB_USER" \
        --dbpass="$DB_PASSWORD" \
        --dbhost="mariadb:3306" \
        --allow-root
else
	echo "WordPress configuration found"
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
else
	echo "WordPress is already installed"
fi

echo "Starting WordPress..."
exec /usr/sbin/php-fpm8.2 -F
