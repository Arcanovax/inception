#!/bin/sh
mkdir -p /run/nginx
chown -R www-data:www-data /var/www/html

echo "Starting Nginx..."
exec nginx -g "daemon off;"