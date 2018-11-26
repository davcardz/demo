FROM php:7.1-cli

RUN apt-get update && apt-get -y install unzip libicu-dev

RUN docker-php-ext-configure intl && \
    docker-php-ext-install intl


ADD . /opt/demo

# Recollim d el'imatge base de composer el que ens interessa
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /opt/demo
RUN composer install
EXPOSE 8000

ENTRYPOINT ["/usr/local/bin/php","bin/console","server:run","*:8000"]
