#!/bin/sh

echo "Starting Redis Cache..."

exec redis-server /etc/redis/redis.conf --bind 0.0.0.0 --protected-mode no --daemonize no
