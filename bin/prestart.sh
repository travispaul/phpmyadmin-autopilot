#!/bin/sh
echo "******running preStart script*********"

while $(curl -s ${CONSUL}:8500/v1/health/state/passing | grep mysql-primary)
do
  echo "mysql-primary not healthly...."
  sleep 5
done

echo "mysql-primary is now healthly, moving on..."

if [ ! -f /etc/phpmyadmin/config.secret.inc.php ] ; then
    cat > /etc/phpmyadmin/config.secret.inc.php <<EOT
<?php
\$cfg['blowfish_secret'] = '$(tr -dc 'a-zA-Z0-9~!@#$%^&*_()+}{?></";.,[]=-' < /dev/urandom | fold -w 32 | head -n 1)';
EOT
fi

mkdir -p /var/nginx/client_body_temp
chown nobody:nobody /sessions /var/nginx/client_body_temp
mkdir -p /var/run/php/
chown nobody:nobody /var/run/php/
touch /var/log/php-fpm.log
chown nobody:nobody /var/log/php-fpm.log

/usr/local/bin/onchange-db.sh
