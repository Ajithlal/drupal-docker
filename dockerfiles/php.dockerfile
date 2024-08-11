FROM php:8.3-fpm-alpine

WORKDIR /var/www/html

COPY ./src .

RUN apk add --no-cache \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    icu-dev \
    oniguruma-dev \
    libzip-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
    opcache \
    intl \
    mbstring \
    zip \
    gd \
    pdo \
    pdo_mysql

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D drupal

USER drupal