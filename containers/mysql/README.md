MySQL container
==============

Build the container: `docker build .`

Start a container: `docker run -d [ID]`


After building and starting the container:

 * Check the IP: `docker inspect <CONTAINER_ID>
 * Run a simple test: `mysql -h <IP> -u admin -p < test.sql`


Setup DNS
---------

Test:

 * Configure the server like this: `redis-cli set redis-dns:mysql.local 172.17.42.XXX`
 * Check what the DNS server says: `dig @[IPAddress] mysql.local`

