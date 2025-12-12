#!/bin/bash

echo "Creating folders..."
mkdir -p /app/static
mkdir -p /app/media
mkdir -p /app/logs

echo "Running migrations..."
python manage.py migrate --noinput

echo "Collecting static files..."
python manage.py collectstatic --noinput

echo "Starting Gunicorn..."
exec gunicorn shayari.wsgi:application \
     --bind 0.0.0.0:8000 \
     --workers 4 \
     --log-level info \
     --access-logfile /app/logs/access.log \
     --error-logfile /app/logs/error.log
