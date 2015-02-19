rsyslog server
==============

This container has a rsyslog server running and listening on UDP port 514.
Any client (container in the network) can log to this rsyslog server.

Build the image: `docker build -t rsyslog .`


Starting the server this way makes it possible to connect and reconnect to the
server:
`docker run -t -i --restart="on-failure:10" --name rsyslog rsyslog /bin/bash -c "supervisord; bash"`

Exit the server with `ctrl-p` `ctrl-q`. Reconnect with `docker attach rsyslog`

There is a example of a client configuration in `rsyslog.conf.client`.
Test to print to syslog with `logger` from a client to make sure things are ok.
