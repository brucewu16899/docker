# Rsyslog server (end example of client configuration)
#
# VERSION               0.0.1

FROM       ubuntu:latest

# Format: MAINTAINER Name <email@addr.ess>
MAINTAINER Jonas Colmsjö <jonas@gizur.com>

RUN echo "export HOME=/root" >> /root/.profile

RUN apt-get update
RUN apt-get install -y wget nano curl git

#
# Install supervisord (used to handle processes)
# ----------------------------------------------
#
# Installation with easy_install is more reliable. apt-get don't always work.

RUN apt-get install -y python python-setuptools
RUN easy_install supervisor

ADD ./etc-supervisord.conf /etc/supervisord.conf
ADD ./etc-supervisor-conf.d-supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /var/log/supervisor/


#
# Install rsyslog
# ---------------
#

RUN apt-get -y install rsyslog
RUN mv /etc/rsyslog.conf /etc/rsyslog.conf.org
ADD ./rsyslog.conf.client /etc/
ADD ./rsyslog.conf.server /etc/rsyslog.conf


#
# Install cron
# ------------

# Run jon every minute
RUN echo '*/1 * * * *  /bin/bash -c "echo `date` testjob, just testing to print to stdout"' > /mycron
RUN crontab /mycron

ADD ./etc-pam.d-cron /etc/pam.d/cron


#
# Start things up
# ----------------
#

EXPOSE 514

CMD ["supervisord"]
