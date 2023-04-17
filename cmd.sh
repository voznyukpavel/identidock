#!/bin/bash
set -e

if [ "$ENV" = 'DEV' ]; then
  echo "Running Development Server"
  exec python "identidock.py"
elif [ "$ENV" = 'UNIT' ]; then 
  echo "Running Unit Tests"
  exec python "tests.py"
elif [ "$ENV" = 'PROD_TEST' ]; then
  echo "Running Production Server after testing"
  exec python "tests.py"
  exec uwsgi --http 0.0.0.0:9090 --wsgi-file /app/identidock.py \
             --callable app --stats 0.0.0.0:9191else
else  
  echo "Running Production Server"
  exec uwsgi --http 0.0.0.0:9090 --wsgi-file /app/identidock.py \
             --callable app --stats 0.0.0.0:
fi
