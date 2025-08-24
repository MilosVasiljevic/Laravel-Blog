# PHP 8.2 FPM (modernija verzija od 7.4)
FROM php:8.2-fpm

# Instalacija sistemskih paketa i PHP ekstenzija
RUN apt-get update && apt-get install -y \
    git curl libpng-dev libonig-dev libxml2-dev zip unzip \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Dodaj Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Postavi radni direktorijum
WORKDIR /var/www/html

# Kopiraj sve fajlove (osim onih u .dockerignore)
COPY . .

# Instaliraj PHP zavisnosti
RUN composer install --no-dev --optimize-autoloader

# Dozvole za Laravel storage i cache
RUN chown -R www-data:www-data storage bootstrap/cache
RUN chmod -R 777 storage bootstrap/cache

# Expose port
EXPOSE 8080

# Start PHP server
CMD ["php", "-S", "0.0.0.0:8080", "-t", "public"]
