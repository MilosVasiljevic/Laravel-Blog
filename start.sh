#!/bin/bash

# Ako nema .env fajla, kopiraj ga
if [ ! -f .env ]; then
  cp .env.example .env
fi

# Migracije i ključevi
php artisan key:generate
php artisan config:clear
php artisan route:clear

# Pokreni Laravel server
php artisan serve --host=0.0.0.0 --port=8000
