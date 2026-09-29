#!/bin/sh

set -e

mkdir -p /run/wordpress
chown -R www-data:www-data /var/www/html

cd /var/www/html

until mysql -h mariadb -u$DB_USER -p$DB_PASSWORD $DB_NAME -e "SELECT 1" > /dev/null 2>&1; do
	echo "Waiting MariaDB..."
    sleep 2
done

echo "MariaDB is ready"

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

wp config set WP_REDIS_HOST redis --allow-root
wp config set WP_REDIS_PORT 6379 --raw --allow-root
wp config set WP_REDIS_DATABASE 0 --raw --allow-root
wp config set WP_REDIS_TIMEOUT 1 --raw --allow-root
wp config set WP_REDIS_READ_TIMEOUT 1 --raw --allow-root
wp config set WP_CACHE true --raw --allow-root
echo "Redis Cache has beed configured"

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

if ! wp plugin is-installed redis-cache --allow-root; then
    echo "Installing Redis Cache plugin..."
    wp plugin install redis-cache --activate --allow-root
else
	echo "Redis Cache is already installed"
fi

wp plugin activate redis-cache --allow-root 2>/dev/null || true

wp redis enable --allow-root || echo "Failed to enable Redis"

echo "Starting WordPress..."
exec /usr/sbin/php-fpm8.2 -F
