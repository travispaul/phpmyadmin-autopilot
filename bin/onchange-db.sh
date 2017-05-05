#!/bin/sh
consul-template \
    -once \
    -dedup \
    -consul ${CONSUL}:8500 \
    -template "/etc/phpmyadmin/config.user.inc.php.ctmpl:/etc/phpmyadmin/config.user.inc.php"