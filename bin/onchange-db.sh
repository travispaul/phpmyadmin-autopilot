#!/bin/bash
consul-template \
    -log-level debug \
    -once \
    -dedup \
    -consul ${CONSUL}:8500 \
    -template "/etc/phpmyadmin/config.user.inc.php.ctmpl:/etc/phpmyadmin/config.user.inc.php"