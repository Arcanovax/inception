FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server mariadb-client

COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]