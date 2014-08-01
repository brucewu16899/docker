Introduction
-----------

This containers contains:

 * MySQL server
 * MongoDB server
 * NodeJS odata server (on top of MongoDB)
 * ssh server
 * tungsten-replicator

The tugsten replication setup is still yet to be configured (the software is installed though).


Usage
-----

Build the docker image and start a container:

```
# Build an image
docker build  .

# Start the container
docker run -d [IMAGE ID]

# Get IP of the started container
docker inspect [container ID]
```

Test that the odata service works: `curl --user admin:admin http://[IP]:52999/newsreader.svc$metadata`

Get users in JSON: `curl --user admin:admin --header "accept: application/json" http://[IP]:52999/newsreader.svc/Users`

List all articles: `curl --user admin:admin --header "accept: application/json" http://[IP]:52999/newsreader.svc/Articles`


If you want to make sure that `mongod` is runing:

```
# Install mongo client
sudo apt-get install -y mongodb-clients

# Connect to mongo
mongo [IP]:27017
```

Setup replication
-----------------

This is work in progress!!


Article describing howto setup replication: http://scale-out-blog.blogspot.se/2011/09/quick-installation-of-replication-from.html

Start a container and login (docker run -t -i [IMAGE ID] /bin/bash) then create a MongoDB user using the `mongo` shell:


Setup the MySQL part:

```
tools/tungsten-installer --master-slave -a \
  --datasource-type=mysql \
  --master-host=localhost  \
  --datasource-user=admin  \
  --datasource-password=mysql-server  \
  --service-name=mongodb \
  --home-directory=/opt/continuent \
  --cluster-hosts=localhost \
  --mysql-use-bytes-for-string=false \
  --svc-extractor-filters=colnames,pkey \
  --svc-parallelization-type=disk --start-and-report
```

Setup the MongoDb part:

```
tools/tungsten-installer --master-slave -a \
  --datasource-type=mongodb \
  --master-host=localhost  \
  --datasource-user=superuser\
  --datasource-password=12345678 \
  --service-name=mongodb \
  --home-directory=/opt/continuent \
  --cluster-hosts=localhost \
  --skip-validation-check=InstallerMasterSlaveCheck \
  --svc-parallelization-type=disk --start-and-report
```


Notes
-----

The `odata-server` `package.json` file is broken. The `connect` module needs to be exactly version `2.0.0`. There is a fix for this in the `Dockerfile`.


