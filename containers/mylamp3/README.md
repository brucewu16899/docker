MySQL, apache and phpMyAdmin container
====================================

MySQL, PHP on apache where PHP versions are managed using phpfarm.
FastCGI is used in apache instead of mod_php. The PHP version is
easily changed in the Dockerfile.


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








