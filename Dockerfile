ARG PHP_VERSION=7.4

FROM composer:latest as composer

FROM php:${PHP_VERSION}-cli

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    libzip-dev \
    git

RUN docker-php-ext-install zip

RUN mkdir -p /app

WORKDIR /app

COPY . .

RUN composer install --no-interaction
