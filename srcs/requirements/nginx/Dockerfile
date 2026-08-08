FROM debian:12.15

RUN apt-get update && apt-get install -y nginx

COPY ./tools/entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

CMD ["sh", "entrypoint.sh"]
