#!/bin/sh

set -e

mkdir -p /run/wordpress
chown -R www-data:www-data /var/www/html

cd /var/www/html

until mysql -h mariadb -u$DB_USER -p$DB_PASSWORD $DB_NAME -e "SELECT 1" > /dev/null 2>&1; do
	echo "Waiting MariaDB..."
    sleep 2
done

echo "MariaDB is ready!"

if [ ! -f /var/www/html/wp-config.php ]; then
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

if ! wp core is-installed --path=/var/www/html --allow-root; then
    echo "Installing WordPress..."
    wp core install \
    --url="https://mthetcha.42.fr" \
    --title="${WP_TITLE}" \
    --admin_user="${WP_ADMIN_USER}" \
    --admin_password="${WP_ADMIN_PASSWORD}" \
    --admin_email="${WP_ADMIN_EMAIL}"  \
    --skip-email \
    --allow-root
    wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
    --path=/var/www/html \
    --role=contributor \
    --user_pass=${WP_USER_PASSWORD} \
    --allow-root
else
	echo "WordPress is already installed"
fi

echo "Starting WordPress..."
exec /usr/sbin/php-fpm8.2 -F
