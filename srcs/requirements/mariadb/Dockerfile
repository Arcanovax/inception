FROM debian:12.15

RUN apt-get update && apt-get install -y mariadb-server mariadb-client
COPY ./tools/entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh

ENTRYPOINT ["/tmp/entrypoint.sh"]
