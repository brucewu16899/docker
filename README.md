Docker.io environment
=====================

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

# This is the redis-dns configuration, change if necessary (primarily IP)
cat /usr/lib/node_modules/redis-dns/redis-dns-config.json

# Check that the redis server is running
sudo service redis-server status

# Check status of redis-dns, restart if the configuration was changed
sudo service redis-dns status
sudo service redis-dns restart

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
redis 127.0.0.1:6379> del redis-dns:dbserver
```


### Setup containers and serives

Create the containers you need, MySQL, Postgres etc. There are script that can be used to setup some containers as services, see
etc/init. Copy the scripts you need to /etc/init and update with the redis-dns IP adress and image ids (efter building the images).

Example setting for MySQL


```
# First create the image
cd containers/mysql
docker build .
...
Successfully built 70391fd54ac4

# Now, setup a container as a service
sudo cp docker-TEMPLATE.conf /etc/init/docker-mysql.conf

# Edit the configuration file
sudo nano /etc/init/docker-mysql.conf
...
env CONTAINER_NAME="mysql"
env REDIS_DNS="172.17.42.1"
env IMAGE_ID="70391fd54ac4"
...

# Start the service and check the log file (should show a container id)
sudo service docker-mysql start
sudo cat /var/log/docker-mysql.log 

# Check the processes
ps -axf
...
1617 ?        Ss     0:00 /bin/sh -e -c /usr/bin/docker -d -H=tcp://127.0.0.1:4243 /bin/sh
 1618 ?        Sl     0:13  \_ /usr/bin/docker -d -H=tcp://127.0.0.1:4243
 2917 ?        S      0:00      \_ lxc-start -n 12db2f8820767c1b2fbd5bfc7017321299fe76cd84fa54a89984566e9306ed97 -f /var/lib/docker/containers/12db2f8820767c1b2fbd5bfc701
 2926 ?        S      0:00          \_ /bin/bash /src/start.sh
 2957 ?        S      0:00              \_ /bin/sh /usr/bin/mysqld_safe
 3292 ?        Sl     0:00              |   \_ /usr/sbin/mysqld --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/usr/lib/mysql/plugin --user=mysql --log-error=/var/l
 3312 ?        S      0:00              \_ /usr/bin/tail -f /var/log/mysql.log
...

# List all docker related services
initctl list |grep docker
docker-mysql start/running
docker start/running, process 1617
network-interface (docker0) start/running
network-interface-security (network-interface/docker0) start/running

```

Setup DNS for the container:

```
# get the container Id
docker ps

# Check what IP that is used
docker inspect 12db2f882076

# Setup the DNS
redis-cli set redis-dns:mysql.local 172.17.0.7
```

Save the image IDs:

```
sudo nano /etc/environment
DOCKER_MYSQL="MySQL image ID here"
REDIS_DNS="enter IP here"
DOCKER_PHP="Enter docker image ID here"
```



For CoreOS
----------

1. Start with creating a container that simplfies the management of CoreOOS: `JACC=$(docker run -d colmsjo/jacc /usr/sbin/sshd -D -e -f /etc/ssh/sshd_config)`
1. `docker ps` will show the containers running. $JACC has the ID for the container just created.
1. Get the IP for the new container: `docker inspect $JACC
 * This will save the IP in a variable: `CONTAINER_IP=$(docker inspect $JACC | grep IPAddress | awk '{ print $2 }' | tr -d ',"')`
1. Now do `ssh root@$CONTAINER_IP`. The password is 'jacc'


Tips and tricks
--------------

1. A `vagrant reload` is often needed after the initial `vagrant up`. Running the bootstrap2.sh script manually is also possible (iot can be executed several times). 
1. Often, docker will consume the disk when several images are built. The way to check what images that consumes the disk space is:
 * containers - `sudo sh -c "ls -d /var/lib/docker/containers/* | xargs du -h -s | sort"`
 * All containers are showed with `docker ps -a` (also those that are stopped)
 * Remove stopped containers not being used (running containers can't be removed so there is no need to worry about that) - `docker rm [ID]`
 * show images - graph      - `sudo sh -c "ls -d /var/lib/docker/graph/* | xargs du -h -s | sort"`
1. Remove intermediate and don't use the cache `docker build -rm -no-cache`
1. Log rotation: [whatever program] | /usr/bin/multilog s1024000 /var/log/yourapp 2>&1

