Gizur.com web site built with Wordpress and 320 theme
====================================================

Contents:

 * wordpress-3.4.2
 * wordpress-bootstrap-v2.3


This wordpress installation has been adapted in order to run on Heroku. See wp-config.php for the details.
There is also a wp-config.php.traditional which can be used on traditional servers (update with MySQL credentials
and rename to wp-config.php).

Heroku is setup in the following way (assuming the heroku command line tools are installed):

```
heroku create --stack cedar --remote production
heroku rename REPO-NAME # Or call it whatever you like for your project

heroku addons:add stillalive:basic
Adding stillalive:basic on mysterious-ravine-7314... done, v3 (free)
Thank you. Please log in to StillAlive via Heroku to setup your monitoring.
Use `heroku addons:docs stillalive:basic` to view documentation.

heroku addons:add cleardb:ignite     # Adds the MySQL option to the Heroku app's config
Adding cleardb:ignite on mysterious-ravine-7314... done, v4 (free)
Use `heroku addons:docs cleardb:ignite` to view documentation.

heroku config                        # See the URLs for your new databases
heroku config:add DATABASE_URL=mysql://... # Replace the "mysql://..." with the URL from CLEARDB_DATABASE_URL

#update cleardb-credentials with the new credentials
```

Update wp-config.php with:

 * random strings from here: https://api.wordpress.org/secret-key/1.1/salt/


Then commit and push to heroku!


Avoid idling
-----------

Heroku will idle the web dyno after a period of inactivity. This can be avoided.

```
heroku ps:scale web=2
```

For develpoment and test environments is 1 web dyno sufficient (and cheaper).


```
heroku ps:scale web=1
```


Watch the number of running processes:

```
watch heroku ps
```


Importing and exporting the MySQL database
------------------------------------------

Saving the cleardb credentials in a text file makes importing and export easier.
Make a copy of cleardb-credentials.template and update with the credemntials for 
the database crated above.


```
heroku config

cp cleardb-credentials.template cleardb-credentials
nano cleardb-credential
```

Import a database dump:

```
git pull

source cleardb-credentials

mysql -u$DBUSER -p$DBPASSWD -h$DBHOST $DBNAM < [DATE].sql
```


Export database when changes has been performed in wordpress:

```
source cleardb-credentials

mysqldump -u$DBUSER -p$DBPASSWD -h$DBHOST $DBNAME > [DATE].sql

git add [DATE].sql
git commit -am "Added new db dump"
git push
```

IMPORTANT: Login to Wordpress and goto the Settings->General

Change the Site Adress (URL) to www.gizur.com for the production instance



Development environement and docker.io
======================================

Linux containers is a nice tecnnology that is increasing in popularity. Below are instructions
for hotwo get started running OpenERP on CoreOS which is using docker containers. See README-OSX.md
for instruction about howto install on OSX.


Pre-requisite:

 * VirtualBox and vagrant, see vagrantup.com
 * Or EC2 instance, minimum m1.medium with 100GB disk

Installation:

1. `vagrant up ubuntu` - create and start a virtual machine - it is also possible to use coreos `vagrant up coreos` 
1. `vagrant ssh ubuntu` - login to the virtual machine - for coreos do `vagrant ssh coreos`

It will take some time to download everything the first time. Starting the virtual machine and
new continers is quickly done once they've been downloaded.


Configuration
------------

docker need to be configured to open up the HTTP API. The start script needs to look something like this `exec /usr/bin/docker -d -H 127.0.0.1:4243`.
For ubuntu, this is changed in `/etc/init/docker.conf`. Now the docker command line tool needs the flag `-H=tcp://127.0.0.1:4242`. Create
an alias for simplcity: `alias docker='docker -H=tcp://127.0.0.1:4243'`. Place this in your `.profile` etc.


### DNS server

DNS server to use in order to access Postgres using a name rather that an IP: `sudo npm install -g redis-dns --production`

```
# First show the IP of the docker bridge
ifconfig |grep -A 7 docker0

# This is the redis-dns configuration
cat /usr/lib/node_modules/redis-dns/redis-dns-config.json

# Check that the redis server is running
sudo service redis-server status

# Start the server using the symlink
./start-redis-dns

# Check the log
sudo cat /var/log/redis-dns.log
```

Test:

 * Configure the server like this: `redis-cli set redis-dns:dbserver.local 172.17.42.100`
 * Check what the DNS server says: `dig @[IPAddress] dbserver.local`


Test within a container:


```
# Start a container, just for playing around in
docker run -t -i -dns=172.17.42.1 ubuntu /bin/bash

# Install dig and nano
apt-get install -y dnsutils nano net-tools ping

# Check if the DNS finds the dbserver that was setup above
dig dbserver
```


Redis CLI:

```
ubuntu@ip-10-48-201-164:~/openerp-env/containers$ redis-cli
redis 127.0.0.1:6379> keys *
1) "redis-dns:dbserver"
redis 127.0.0.1:6379> get redis-dns:dbserver
"172.17.42.100"
```



Tips and tricks
--------------

1. Often, docker will consume the disk when several images are built. The way to check what images that consumes the disk space is:
 * containers - `sudo sh -c "ls -d /var/lib/docker/containers/* | xargs du -h -s | sort"`
 * All containers are showed with `docker ps -a` (also those that are stopped)
 * Remove stopped containers not being used (running containers can't be removed so there is no need to worry about that) - `docker rm [ID]`
 * show images - graph      - `sudo sh -c "ls -d /var/lib/docker/graph/* | xargs du -h -s | sort"`

