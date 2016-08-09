#!/bin/bash
#set -x #echo on

echo "-----------------------"
echo "setup permissions"
echo "-----------------------"

cd ${LARAVEL_WWW_PATH}

# application run dirs
#chown -R www-data ${LARAVEL_WWW_PATH}

mkdir -p ${LARAVEL_STORAGE_PATH}
mkdir ${LARAVEL_STORAGE_PATH}/app
mkdir ${LARAVEL_STORAGE_PATH}/framework
mkdir ${LARAVEL_STORAGE_PATH}/framework/sessions
mkdir ${LARAVEL_STORAGE_PATH}/framework/views
mkdir ${LARAVEL_STORAGE_PATH}/framework/cache
mkdir ${LARAVEL_STORAGE_PATH}/logs
#chown -R www-data ${LARAVEL_STORAGE_PATH}
chmod -R 777 ${LARAVEL_STORAGE_PATH}

mkdir -p ${LARAVEL_BOOTSTRAP_CACHE_PATH}
#chown -R www-data ${LARAVEL_BOOTSTRAP_CACHE_PATH}
chmod -R 777 ${LARAVEL_BOOTSTRAP_CACHE_PATH}

echo "-----------------------"
echo "Migrate"
echo "-----------------------"

[ -f /etc/hosts ] && echo "Found" || echo "Not found"
php artisan migrate

echo "-----------------------"
echo "Starting PHP FPM"
echo "-----------------------"

exec php-fpm

