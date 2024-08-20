# Use an official PHP runtime as a parent image
FROM php:8.2-fpm

# Set working directory
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    git \
    nodejs \
    npm \
    nginx

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip pdo pdo_mysql

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy the application code
COPY . .

# Install Node.js packages
RUN npm install

# Build Tailwind CSS and other assets
RUN npm run build

# Copy the Nginx configuration file
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Expose port 80 for the web server
EXPOSE 80

# Start PHP-FPM and Nginx
CMD service nginx start && php-fpm
