#
# Dockerfile that builds container with Apache and PHP
# When not using vagrant, run it manually with: docker build - < Dockerfile
#


# Image: PHP
#
# VERSION               0.0.1

FROM     ubuntu
MAINTAINER Jonas Colmsjö "jonas@gizur.com"


# -----------------------------------------------------------------------------------
# PREPARATIONS 
#


RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update


#
# Install some nice tools (mainly used for debugging)
#

RUN apt-get install -y curl wget lynx git mysql-client


#
# Install Apache and PHP
#

RUN apt-get install -y apache2 php5 php5-curl php5-mysql php5-mcrypt


# -----------------------------------------------------------------------------------
# SETUP THE APP
#

# Bundle everything and install
ADD ./src /var/www
ADD ./conf/etc /etc

RUN cd /var/www; tar -xzf phpMyAdmin-4.0.8-all-languages.tar.gz
RUN rm /var/www/index.html

ADD ./config.inc.php /var/www/phpMyAdmin-4.0.8-all-languages/config.inc.php
 
#RUN mv /tmp/config.inc.php /var/www

#RUN cd /var/www && curl -sS https://getcomposer.org/installer | php
#RUN mv /var/www/composer.phar /var/www/composer
#RUN cd /var/www && ./composer install
#RUN cp /var/www/config.inc.php /var/www/vendor/phpmyadmin/phpmyadmin



EXPOSE  8080 8443
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
