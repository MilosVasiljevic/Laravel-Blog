FROM php:8.2-fpm

# Instalacija sistemskih paketa i ekstenzija
RUN apt-get update && apt-get install -y \
    git curl libpng-dev libonig-dev libxml2-dev zip unzip \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Postavljanje radnog direktorijuma
WORKDIR /var/www

# Kopiraj sve fajlove
COPY . .

# Instaliraj PHP dependencije
RUN composer install

# Kreiraj .env
RUN cp .env.example .env

# Set permissions
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Laravel commands
RUN php artisan config:clear
RUN php artisan route:clear

# Expose port
EXPOSE 8000

# Start komandna linija
CMD php artisan serve --host=0.0.0.0 --port=8000
