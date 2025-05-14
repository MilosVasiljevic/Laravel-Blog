FROM php:8.2-fpm

# Instalacija sistemskih paketa
RUN apt-get update && apt-get install -y \
    git curl libpng-dev libonig-dev libxml2-dev zip unzip \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Dodaj Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Postavi radni direktorijum
WORKDIR /var/www

# Kopiraj fajlove u image
COPY . .

# Instaliraj PHP zavisnosti
RUN composer install --no-dev --optimize-autoloader

# Kopiraj .env.example u .env
RUN cp .env.example .env

# Generiši Laravel ključ
RUN php artisan key:generate

# Očisti konfiguracije i rute
RUN php artisan config:clear && php artisan route:clear

# Dozvole
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Expose port
EXPOSE 8000

# Startuj server
CMD php artisan serve --host=0.0.0.0 --port=8000
