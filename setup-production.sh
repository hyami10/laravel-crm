#!/bin/bash

# Production setup script for Laravel CRM
# This script is safe to run multiple times without data loss

set -e  # Exit on any error

echo "Starting production deployment..."

# Build and run docker-compose (only rebuild if needed)
echo "Building and starting containers..."
docker compose up -d --build

# Container IDs by image name
apache_container_id=$(docker ps -aqf "name=krayin-php-apache")
db_container_id=$(docker ps -aqf "name=krayin-mysql")

if [ -z "$apache_container_id" ] || [ -z "$db_container_id" ]; then
    echo "Error: Could not find required containers"
    exit 1
fi

# Wait for MySQL connection
echo "Waiting for MySQL connection..."
timeout=60
counter=0
while ! docker exec ${db_container_id} mysql --user=root --password=root -e "SELECT 1" >/dev/null 2>&1; do
    sleep 1
    counter=$((counter + 1))
    if [ $counter -gt $timeout ]; then
        echo "Error: MySQL connection timeout"
        exit 1
    fi
done

# Create database if it doesn't exist (safe for production)
echo "Ensuring database exists..."
docker exec ${db_container_id} mysql --user=root --password=root -e "CREATE DATABASE IF NOT EXISTS krayin CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

# Create testing database if it doesn't exist
echo "Ensuring testing database exists..."
docker exec ${db_container_id} mysql --user=root --password=root -e "CREATE DATABASE IF NOT EXISTS krayin_testing CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

echo "Setting up Laravel CRM project..."

# Install/update composer dependencies
echo "Installing composer dependencies..."
docker exec -i ${apache_container_id} bash -c "cd krayin && composer install --no-dev --optimize-autoloader"

# Copy environment files
echo "Updating environment configuration..."
docker cp .configs/.env ${apache_container_id}:/var/www/html/krayin/.env
docker cp .configs/.env.testing ${apache_container_id}:/var/www/html/krayin/.env.testing

# Production-safe database operations
echo "Running database migrations..."
docker exec -i ${apache_container_id} sh -c "cd krayin && php artisan down --retry=60"

# Clear caches before migration
docker exec -i ${apache_container_id} sh -c "cd krayin && php artisan config:clear && php artisan cache:clear"

# Run migrations (safe - only applies new migrations)
docker exec -i ${apache_container_id} sh -c "cd krayin && php artisan migrate --force"

# Other production setup commands
echo "Finalizing setup..."
docker exec -i ${apache_container_id} sh -c "cd krayin && php artisan storage:link"
docker exec -i ${apache_container_id} sh -c "cd krayin && php artisan vendor:publish --provider='Webkul\\Core\\Providers\\CoreServiceProvider' --force"

# Optimize for production
docker exec -i ${apache_container_id} sh -c "cd krayin && php artisan config:cache && php artisan route:cache && php artisan view:cache"

# Bring the application back up
docker exec -i ${apache_container_id} sh -c "cd krayin && php artisan up"

echo "Production deployment completed successfully!"
echo "Application is ready at your configured URL"