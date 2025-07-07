FROM php:8.2-cli

# Install system dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    libzip-dev \
    zip \
    curl

# Enable PHP extensions
RUN docker-php-ext-install zip

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /app

# Copy code
COPY . .

# Install PHP dependencies
RUN composer install

# Expose port
EXPOSE 10000

# Start Slim app with built-in PHP server
CMD ["php", "-S", "0.0.0.0:10000", "index.php"]
