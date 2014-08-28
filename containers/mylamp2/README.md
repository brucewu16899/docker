MySQL, apache and phpMyAdmin container
====================================

PHP versions are managed with phpbrew.  I have not been able to get apache
to use the phpbrew PHP versions though. See mylamp3 for a setup where this 
works.


Build the container: `docker build --rm .`

Start a container: `docker run -d -p 80:80 [IMAGE ID]`


MySQL
-----

MySQL credentials:

 * admin / mysql-server
 * gizur_com / 48796e76


Development environemnet
-----------------------

Login to phpMyAdmin at: `http://localhost:PORT/phpMyAdmin-4.0.8-all-languages`

Monitoring is enabled and accessable from the networj 172.0.0.0/8 (change this is status.conf if your network 
settings differ).

Install lynx and start:

```
apt-get install -y lynx
lynx http://localhost/server-status
```








