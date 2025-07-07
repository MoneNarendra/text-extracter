FROM php:8.2-cli

# Install dependencies
RUN apt-get update && \
    apt-get install -y tesseract-ocr libtesseract-dev && \
    apt-get clean

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working dir
WORKDIR /app

# Copy your app
COPY . .

# Install PHP deps
RUN composer install --no-dev --optimize-autoloader

# Expose port
EXPOSE 10000

# Start Slim app
CMD ["php", "-S", "0.0.0.0:10000", "-t", "public"]
