#!/bin/bash

mkdir -p /var/www/html/web
mkdir -p /tmp/task2

crontab -l > /tmp/mycron

echo "0 * * * * /tmp/task2/readstats.sh" >> /tmp/mycron
echo "1 * * * * /tmp/task2/calcavgs.sh" >> /tmp/mycron

crontab /tmp/mycron



