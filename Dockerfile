FROM celinederoland/php8.1-apache
# Copy composer.lock and composer.json into the working directory
COPY laravel/composer.* /var/www/html/

# Set working directory
WORKDIR /var/www/html/

RUN docker-php-ext-install bcmath && \
    a2enmod rewrite && \
    rm /etc/apache2/sites-enabled/*

# Install dependencies for the operating system software
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    libzip-dev \
    unzip \
    git \
    libonig-dev \
    curl

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions for php
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd

# Install composer (php package manager)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy existing application directory contents to the working directory
COPY laravel/ /var/www/html/

# Run composer install to install the dependencies
RUN composer install
    
COPY apache2/sites-enabled/*.conf /etc/apache2/sites-enabled/
COPY .env.prod /var/www/html/.env

ENV APP_DEBUG=false
ENV APP_ENV=production

RUN php artisan config:cache && \
    php artisan route:cache && \
    php artisan view:cache && \
    chmod 0777 -R /var/www/html/storage