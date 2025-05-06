composer install

cp .env.example .env

php artisan key:generate

// $categories = Category::take(5)->get();
// View::share('categories', $categories);

// $setting = Setting::first();
// View::share('setting', $setting);

php artisan migrate --seed

$categories = Category::take(5)->get();
View::share('categories', $categories);

$setting = Setting::first();
View::share('setting', $setting);

newuser@example.com
password123