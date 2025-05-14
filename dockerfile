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

COPY .env .env


# Instaliraj PHP dependencije
RUN composer install --no-dev --optimize-autoloader

# Dozvole
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Kopiraj start skriptu
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8000

# Pokreni Laravel server kroz skriptu
CMD ["/start.sh"]
