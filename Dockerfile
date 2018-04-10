FROM php:7.2-apache


# Tweaks if you have permission problem
ENV DOCKER_ID 1000
RUN usermod -u ${DOCKER_ID} www-data && \
    usermod -G staff www-data

RUN a2enmod rewrite

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd
    && docker-php-ext-install pdo_mysql
    && docker-php-ext-install zip
