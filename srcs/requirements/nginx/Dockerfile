FROM debian:12.15

RUN apt-get update && apt-get install -y nginx openssl curl

RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/mthetcha.42.fr.key \
    -out /etc/nginx/ssl/mthetcha.42.fr.crt \
    -subj "/C=FR/ST=Auvergne-Rhone-Alpes/L=Lyon/O=42/CN=mthetcha.42.fr"

RUN rm /etc/nginx/sites-enabled/default

COPY ./tools/nginx.conf /etc/nginx/conf.d/default.conf

COPY ./tools/entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

CMD ["sh", "entrypoint.sh"]
