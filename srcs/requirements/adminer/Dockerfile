FROM debian:bookworm

RUN apt-get update && apt-get install -y adminer php8.2-cli php8.2-mysql

COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]