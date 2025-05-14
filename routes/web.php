<?php

use Illuminate\Support\Facades\Route;

use Illuminate\Support\Facades\Artisan;

use Illuminate\Support\Facades\File;


Auth::routes();

Route::get('/ping', fn() => 'pong');

Route::get('/debug-log', function () {
    $logPath = storage_path('logs/laravel.log');
    if (!file_exists($logPath)) {
        return 'Log file does not exist.';
    }

    return response()->file($logPath);
});


// help
Route::get('/migrate', function () {
    Artisan::call('migrate', ['--force' => true]);
    return 'Migration complete';
});

Route::get('/key', function () {
    Artisan::call('key:generate');
    return 'Key generated';
});

Route::get('/link', function () {
    Artisan::call('storage:link');
    return 'Storage linked';
});

Route::get('/logs', function () {
    try {
        $logPath = storage_path('logs/laravel.log');
        if (!File::exists($logPath)) return 'Log file not found.';
        $log = File::get($logPath);
        return nl2br(e(Str::limit($log, 8000)));
    } catch (\Exception $e) {
        return 'Log error: ' . $e->getMessage();
    }
});


Route::get('/home', 'HomeController@index')->name('home');

// Front End Routes
Route::get('/', 'FrontEndController@home')->name('website');
Route::get('/about', 'FrontEndController@about')->name('website.about');
Route::get('/category/{slug}', 'FrontEndController@category')->name('website.category');
Route::get('/tag/{slug}', 'FrontEndController@tag')->name('website.tag');
Route::get('/contact', 'FrontEndController@contact')->name('website.contact');
Route::get('/post/{slug}', 'FrontEndController@post')->name('website.post');

// users
Route::get('/users', 'FrontEndController@users')->name('website.users');

// user page
Route::get('/user/{id}', 'FrontEndController@user')->name('website.user');

Route::post('/contact', 'FrontEndController@send_message')->name('website.contact');

// Admin Panel Routes
Route::group(['prefix' => 'admin', 'middleware' => ['auth']], function () {
    Route::get('/dashboard','DashboardController@index')->name('dashboard');

    Route::resource('category', 'CategoryController');
    Route::resource('tag', 'TagController');
    Route::resource('post', 'PostController');
    Route::resource('user', 'UserController');
    Route::get('/profile', 'UserController@profile')->name('user.profile');
    Route::post('/profile', 'UserController@profile_update')->name('user.profile.update');
    
    // setting
    Route::get('setting', 'SettingController@edit')->name('setting.index');
    Route::post('setting', 'SettingController@update')->name('setting.update');

    // Contact message
    Route::get('/contact', 'ContactController@index')->name('contact.index');
    Route::get('/contact/show/{id}', 'ContactController@show')->name('contact.show');
    Route::delete('/contact/delete/{id}', 'ContactController@destroy')->name('contact.destroy');
});
