fcron docker image
===================

Build with: `docker build --rm -t fcron .`

Run the container interactive mode for testing purposes : `docker run -t -i --rm fcron /bin/bash`.

The date is printed every minute for testing purposes. Default crontab:
`"*/1 * * * *  sh -c date >> /var/log/cronjob"`

`fcrontab -l` will list the current cron jobs

`fcrontab [FILE]` will install new cron jobs for the current user

In production: `docker run -d fcron`

