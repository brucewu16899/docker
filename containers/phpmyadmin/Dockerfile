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
ADD ./src /tmp
ADD ./conf/etc /etc

#RUN wget -O /phpMyAdmin-4.0.8-all-languages.tar.gz http://downloads.sourceforge.net/project/phpmyadmin/phpMyAdmin/4.0.8/phpMyAdmin-4.0.8-all-languages.tar.gz?r=http%3A%2F%2Fwww.phpmyadmin.net%2Fhome_page%2Fdownloads.php&ts=1382555887&use_mirror=garr
RUN tar -xzf /tmp/phpMyAdmin-4.0.8-all-languages.tar.gz
RUN mv /tmp/phpMyAdmin-4.0.8-all-languages/* /var/www 
RUN rm /var/www/index.html 
RUN mv /tmp/config.inc.php /var/www

#RUN cd /var/www && curl -sS https://getcomposer.org/installer | php
#RUN mv /var/www/composer.phar /var/www/composer
#RUN cd /var/www && ./composer install
#RUN cp /var/www/config.inc.php /var/www/vendor/phpmyadmin/phpmyadmin



EXPOSE  8080 8443
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
