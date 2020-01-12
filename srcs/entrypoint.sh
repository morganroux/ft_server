service mysql start
service php7.3-fpm start
mysql -u root < /etc/config.sql
service nginx start
sleep infinity && wait
