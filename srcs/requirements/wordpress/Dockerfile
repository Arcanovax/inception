FROM debian:12.15

RUN apt-get update && apt-get install -y \
    php8.2-fpm \
    php8.2-mysqli \
    php8.2-curl \
    php8.2-gd \
    php8.2-xml \
    php8.2-mbstring \
    php8.2-zip \
    php8.2-intl \
    mariadb-client \
    curl \
    wget \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN sed -i 's/^listen = .*/listen = 0.0.0.0:9000/' /etc/php/8.2/fpm/pool.d/www.conf

WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz \
    && rm latest.tar.gz \
    && mv wordpress/* . \
    && rm -rf wordpress

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp 

RUN echo "listen = 0.0.0.0:9000" >> /etc/php/8.2/fpm/pool.d/www.conf \
    && echo "clear_env = no" >> /etc/php/8.2/fpm/pool.d/www.conf

COPY ./tools/entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

CMD ["sh", "entrypoint.sh"]
