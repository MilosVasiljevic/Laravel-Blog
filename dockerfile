FROM php:7.4-fpm

# Instalacija sistemskih paketa
RUN apt-get update && apt-get install -y \
    git curl libpng-dev libonig-dev libxml2-dev zip unzip \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Dodaj Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Postavi radni direktorijum
WORKDIR /var/www

# Kopiraj fajlove
COPY . . 

# Kopiraj .env fajl
COPY .env .env

# Instaliraj PHP dependencije
RUN composer install --no-dev --optimize-autoloader

# Dozvole za direktorijume
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Dozvole za čitanje i pisanje
RUN chmod -R 777 storage bootstrap/cache

# Expose port 8000
EXPOSE 8000

# Pokreni PHP server sa public/ kao root
CMD ["php", "-S", "0.0.0.0:8000", "-t", "public"]

