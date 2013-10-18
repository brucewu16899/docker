MySQL container
==============

Build the container: `docker build .`

Start a container: `docker run -d [ID]`

After building and starting the container, check the IP: `docker inspect <CONTAINER_ID>

Run a simple test.

```
# Start a container, just for playing around in
docker run -t -i -dns=172.17.42.1 ubuntu /bin/bash

# Install dig and nano
apt-get install -y dnsutils nano net-tools ping mysql-client

# Check if the DNS finds the dbserver that was setup above
dig mysql.local

echo "SELECT 1 + 1 AS solution;" | mysql -h mysql.local -u admin -p
```




Setup DNS
---------

Test:

 * Configure the server like this: `redis-cli set redis-dns:mysql.local 172.17.42.XXX`
 * Check what the DNS server says: `dig @[IPAddress] mysql.local`

