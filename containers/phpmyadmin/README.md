Build image with `docker build .`

Run with the flag: `docker run -dns=172.17.42.1 [ID]`

This DNS flag is necessary if redis-dns service is used to setup networking between containers.
