FROM php:7.0.6-fpm

COPY config/custom.ini /usr/local/etc/php/conf.d/

RUN apt-get update && apt-get install -y zlib1g-dev libexif-dev libicu-dev libpng-dev libjpeg-dev libpq-dev nano \
    && docker-php-ext-install opcache \
    && docker-php-ext-install intl \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install pdo_pgsql \
    && docker-php-ext-install exif \
    && docker-php-ext-install gd \
    ## APCu
    && pecl install apcu-5.1.3 \
    && docker-php-ext-enable apcu
   # && pecl install xdebug-2.4.0

# start and setup scripts
# setup script runs on container startup to utilize GITHUB_TOKEN env variable
ADD bin/setup.sh /tmp/php-app/
RUN chmod 755 /tmp/php-app/setup.sh

# Default ENV
# ------------------
ENV LARAVEL_WWW_PATH=/var/www/html \
    LARAVEL_STORAGE_PATH=/var/www/html/storage \
    LARAVEL_BOOTSTRAP_CACHE_PATH=/var/www/html/bootstrap/cache \
    TERM=xterm

CMD sh /var/www/html/ebconfig/bin/setup.sh
