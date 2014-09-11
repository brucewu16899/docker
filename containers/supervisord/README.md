batches in supervisord
======================

Build with: `docker build --rm -t supervisord .`

Run the container interactive mode for testing purposes : 
`docker run -t -i --rm supervisord /bin/bash`.

Start everything: `/start.sh &`. Some data is written to `/var/log/batches.log`
for testing purposes.
