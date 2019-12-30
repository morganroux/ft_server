FROM debian:buster
RUN apt-get update && apt-get upgrade && apt-get dist-upgrade -qy
RUN apt-get install apt-utils -qy
RUN apt-get install software-properties-common -qy
RUN apt-get update -qy 
# install wget, nginx, mysql
RUN apt-get install wget -yq
RUN apt-get install -qy php7.3-fpm php7.3-common php7.3-mysql php7.3-xml php7.3-xmlrpc php7.3-curl php7.3-gd php7.3-imagick php7.3-cli php7.3-dev php7.3-imap php7.3-mbstring php7.3-soap php7.3-zip php7.3-bcmath
RUN apt-get install nginx -qy
RUN apt-get install default-mysql-server -qy
RUN apt-get install vim -yq
RUN apt-get install procps -yq
# clean apt
RUN apt-get clean -y
# copy wordpress files
COPY srcs/wordpress /var/www/html/wordpress
RUN chown -R www-data:www-data /var/www/html/wordpress && chmod -R 755 /var/www/html/wordpress
# install phpmyadmin
RUN cd /var/www/html \
	&& wget https://files.phpmyadmin.net/phpMyAdmin/4.9.2/phpMyAdmin-4.9.2-all-languages.tar.gz \
	&& tar -xvf phpMyAdmin-4.9.2-all-languages.tar.gz \
	&& mv phpMyAdmin-4.9.2-all-languages phpmyadmin \
	&& rm phpMyAdmin-4.9.2-all-languages.tar.gz
#VOLUME /var/www/html
# configure ssl
#RUN apt-get install openssl -yq
#COPY srcs/localhost.conf /etc/localhost.conf
#RUN cd /etc/ \
#	&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout localhost.key -out localhost.crt -config localhost.conf \
#	&& cp /etc/localhost.crt /etc/ssl/certs/localhost.crt \
#	&& cp /etc/localhost.key /etc/ssl/private/localhost.key
COPY srcs/localhost.crt /etc/ssl/certs/localhost.crt 
COPY srcs/localhost.key /etc/ssl/private/localhost.key

# configure nginx
COPY srcs/default /etc/nginx/sites-available/default
# run server
EXPOSE 80
EXPOSE 443
COPY srcs/entrypoint.sh /etc/entrypoint.sh
COPY srcs/config.sql /etc/config.sql
RUN chmod +x /etc/entrypoint.sh
ENTRYPOINT ["/etc/entrypoint.sh"]
