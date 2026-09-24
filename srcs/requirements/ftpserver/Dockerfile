
FROM debian:bookworm

RUN apt-get update && apt-get install -y vsftpd

RUN mkdir -p /var/run/vsftpd/empty

RUN echo "anonymous_enable=NO" >> /etc/vsftpd.conf && \
    echo "local_enable=YES" >> /etc/vsftpd.conf && \
    echo "write_enable=YES" >> /etc/vsftpd.conf && \
    echo "chroot_local_user=YES" >> /etc/vsftpd.conf && \
    echo "pasv_enable=YES" >> /etc/vsftpd.conf && \
    echo "pasv_min_port=30000" >> /etc/vsftpd.conf && \
    echo "pasv_max_port=30005" >> /etc/vsftpd.conf && \
	echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf


COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh


ENTRYPOINT ["/entrypoint.sh"]
