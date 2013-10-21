1. Setup the confdiguration: `cp config.inc.php.template config.inc.php`
 * Edit `config.inc.php`. It is typically only this row that needs to be updated: `$cfg['Servers'][$i]['host'] = 'localhost';`.

1. Build image with `docker build .`

1. Run with the flag: `docker run -dns=172.17.42.1 [ID]`
 * This DNS flag is necessary if redis-dns service is used to setup networking between containers.

1. Now start phpMyAdmin: http://[HOST]:[PORT]/vendor/phpmyadmin/phpmyadmin/
