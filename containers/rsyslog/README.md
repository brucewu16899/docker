logging server
==============

This container has a rsyslog server running and listening on UDP port 514.
Any client (container in the network) can log to this rsyslog server.

There is also a logstash server and elasticsearch. This is the future setup.

Build the image: `docker build -t logserver .`


Starting the server this way makes it possible to connect and reconnect to the
server:

    docker run -t -i --restart="on-failure:10" --name logserver -h logserver \
    logserver /bin/bash -c "supervisord; bash"

Exit the server with `ctrl-p` `ctrl-q`. Reconnect with `docker attach rsyslog`

There is a example of a client configuration in `rsyslog.conf.client`.
Test to print to syslog with `logger` from a client to make sure things are ok.
