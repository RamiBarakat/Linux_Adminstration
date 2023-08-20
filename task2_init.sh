#!/bin/bash

systemctl start httpd
systemctl enable httpd

mkdir -p /var/www/html/web
mkdir -p /tmp/task2

crontab -l > /tmp/mycron

echo "0 * * * * /tmp/task2/task2_readstats.sh" >> /tmp/mycron
echo "1 * * * * /tmp/task2/task2_calcaverage.sh" >> /tmp/mycron

crontab /tmp/mycron
rm -f /tmp/mycron

cat << EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>System Statistics</title>
</head>
<body>
    <h1>System Statistics</h1>
    <ul>
        <li><a href="cpu.html">CPU Usage</a></li>
        <li><a href="memory.html">Memory Usage</a></li>
        <li><a href="disk.html">Disk Usage</a></li>
    </ul>
</body>
</html>
EOF

lynx /var/www/html/index.html
