from ubuntu:12.04
maintainer Jonas Colmsjö <jonas@gizur.com>

run echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list # 20103-08-24
run apt-get update
run apt-get install -q -y language-pack-en
run update-locale LANG=en_US.UTF-8

#run echo mail > /etc/hostname
add etc-hosts.txt /etc/hosts
#run chown root:root /etc/hosts

run apt-get install -q -y vim

# Install Postfix.
run echo "postfix postfix/main_mailer_type string Internet site" > preseed.txt
run echo "postfix postfix/mailname string mail.example.com" >> preseed.txt
# Use Mailbox format.
run debconf-set-selections preseed.txt
run DEBIAN_FRONTEND=noninteractive apt-get install -q -y postfix

run postconf -e myhostname=mail.example.com
run postconf -e mydestination="mail.example.com, example.com, localhost.localdomain, localhost"
run postconf -e mail_spool_directory="/var/spool/mail/"
run postconf -e mailbox_command=""

# Add a local user to receive mail at someone@example.com, with a delivery directory
# (for the Mailbox format).
run useradd -s /bin/bash someone
run mkdir /var/spool/mail/someone
run chown someone:mail /var/spool/mail/someone

add etc-aliases.txt /etc/aliases
#run chown root:root /etc/aliases
#run rm /etc/aliases.db
run /bin/sh -c "cd /etc; postmap aliases"
run newaliases

# Use syslog-ng to get Postfix logs (rsyslog uses upstart which does not seem
# to run within Docker).
run apt-get install -q -y syslog-ng


#
# Jonas C.
#

# Good foor debugging
run apt-get -y install mutt vim dnsutils wget curl

# Need to use smarthost when running in docker (since these IP-adresses often are blocked for spam purposes)
# See: http://www.inboxs.com/index.php/linux-os/mail-server/52-configure-postfix-to-use-smart-host-gmail

run echo smtp.gmail.com USERNAME:PASSWORD > /etc/postfix/relay_passwd
run chmod 600 /etc/postfix/relay_passwd
run postmap /etc/postfix/relay_passwd
add etc-postfix-main.cf /etc-postfix-main.cf
run cat /etc-postfix-main.cf >> /etc/postfix/main.cf


#-------------------------------------------------------------------------
# Install apache
#

# Keep upstart from complaining
#RUN dpkg-divert --local --rename --add /sbin/initctl
#RUN ln -s /bin/true /sbin/initctl

#RUN apt-get update


#
# Install supervidord (used to handle processes)
#

RUN apt-get install -y supervisor
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf


#
# Install Apache


RUN apt-get install -y apache2


#-------------------------------------------------------------------------
# Install mailman
#

#run echo "postfix postfix/mailname string mail.example.com" > preseed.txt
#run debconf-set-selections preseed.txt
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mailman

#run echo "postfix postfix/mailname string mail.example.com" > preseed.txt
#run debconf-set-selections preseed.txt
RUN newlist mailman

#RUN groupadd mailman
#RUN useradd -c "GNU Mailman" -s /no/shell -d /no/home -g mailman mailman
#RUN mkdir -p /usr/local/mailman
#RUN cd /usr/local/mailman; chgrp mailman .; chmod a+rx,g+ws .

#RUN wget https://launchpad.net/mailman/3.0/3.0.0b3/+download/mailman-3.0.0b3.tar.gz
#RUN tar -xzf mailman-3.0.0b3.tar.gz

#RUN sudo su mailman -c "cd /usr/local/mailman/mailman-3.0.0b3; ./configure; man install"

expose 25
cmd ["sh", "-c", "service syslog-ng start ; service postfix start ; /usr/lib/mailman/bin/mailmanctl start; tail -F /var/log/mailman/*"]
