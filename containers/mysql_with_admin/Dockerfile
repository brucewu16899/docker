# MySQL Server
#
# VERSION               0.0.1

FROM     base
MAINTAINER Prabhat Khera "prabhat.khera@gmail.com"


# Keep upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl

RUN apt-get update

#
# Install some nice tools (mainly used for debugging)
#

RUN apt-get install -y curl lynx git


#
# Install Apache and PHP
# ---------------------

RUN apt-get install -y apache2 php5 php5-curl php5-mysql 

# Bundle everything and install
ADD ./src /var/www
ADD ./conf/etc /etc

RUN cd /var/www && curl -sS https://getcomposer.org/installer | php
RUN mv /var/www/composer.phar /var/www/composer
RUN cd /var/www && ./composer install


#
# Install MySQL
# -------------


# Bundle everything
ADD . /src

# Install MySQL server
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server && apt-get clean && rm -rf /var/lib/apt/lists/*

# Fix configuration
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Setup admin user
RUN /src/mysql-setup.sh


EXPOSE  8080 8443 3306
CMD ["/src/start.sh"]


