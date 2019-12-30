#!/usr/bin/env bash 
service mysql start
service php7.3-fpm start
mysql -u root < /etc/config.sql
nginx -g 'daemon off;'
