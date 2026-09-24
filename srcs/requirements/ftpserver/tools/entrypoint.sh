#!/bin/sh

echo "Starting FTP Server..."

if ! id "$FTP_USER" >/dev/null 2>&1; then
    echo "Creating FTP user $FTP_USER"
    useradd -ms /bin/bash "$FTP_USER"
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
    usermod -d /var/www/html "$FTP_USER"
fi

exec vsftpd /etc/vsftpd.conf
