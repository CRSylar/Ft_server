# -*- 	Dockerfile -*-

FROM debian:buster


#update & install LEMP kit
RUN apt-get update && \
	apt-get install -y nginx \
	mariadb-server \
	php7.3-fpm \
	php7.3-mysql \
	wget \
	openssl

#config nginx
COPY srcs/default /etc/nginx/sites-available/default

#Crea certificato SSL
RUN openssl req -days 365 -newkey rsa:2048 -nodes -keyout /etc/ssl/private/localhost.key \
	-x509 -out /etc/ssl/certs/localhost.crt \
	-subj '/C=IT'

#Wordpress install & set
RUN wget https://wordpress.org/latest.tar.gz && \
	tar -xvf latest.tar.gz -C /var/www/html/ && \
	rm latest.tar.gz

COPY srcs/wp-config.php /var/www/html/wordpress/
COPY srcs/wordpress_conf.sql /tmp/
RUN service mysql start && \
	mysql -u root < /tmp/wordpress_conf.sql

#Phpmyadmin install & set
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.5/phpMyAdmin-4.9.5-all-languages.tar.gz && \
	tar -xvf phpMyAdmin-4.9.5-all-languages.tar.gz && \
	mv phpMyAdmin-4.9.5-all-languages /var/www/html/phpMyAdmin && \
	rm -rf phpMyAdmin-4.9.5-all-languages.tar.gz

COPY srcs/config.inc.php /var/www/html/phpMyAdmin/

COPY srcs/autoindexsw.sh /tmp/
COPY srcs/entrypoint.sh /tmp/

RUN chown www-data:www-data /var/www/html/*
RUN chmod 755 /tmp/*


EXPOSE 80 443

ENTRYPOINT ["/bin/bash","/tmp/entrypoint.sh"]
