docker API
---------

The example below illustrates hiw the API can be used. Make sure to replace the image and container
id when running the commands.

```
# List containers
curl -G http://localhost:4243/containers/json

# Should give the same list
docker ps

# Build a new image
curl -H "Content-type: application/tar" --data-binary @webapp.tar http://localhost:4243/build
...
Step 17 : CMD ["node", "/src/index.js"]
 ---> Running in 7c325d0c8b84
 ---> e29f1e430a8e
Successfully built e29f1e430a8e

# create a container with the new image
curl -H "Content-Type: application/json" -d @create.json http://localhost:4243/containers/create
{"Id":"c6bfd6da99d3"}

# start the new container
curl -H "Content-Type: application/json" -d @start.json http://localhost:4243/containers/c6bfd6da99d3/start

# Get the logs of the started container (should show the current date since that's all the container does)
curl -H "Content-Type: application/vnd.docker.raw-stream" -d '' "http://localhost:4243/containers/c6bfd6da99d3/attach?logs=1&stream=0&stdout=1"

# Inspect the container
curl -G http://localhost:4243/containers/c6bfd6da99d3/json
```


hipache configuration
--------------------

hipache is configured through a redis database.

First make sure that redis is running (assuming it already is installed):
`sudo service redis-server status`


```
# start hipache
./node_modules/hipache/bin/hipache --config config.json

# Create a front-end
redis-cli rpush frontend:www.dotcloud.com mywebsite

# Assuming a back-end is available at http://192.168.0.42:8080
redis-cli rpush frontend:www.example.com http://192.168.0.42:8080

# Show configuration
redis-cli lrange frontend:www.dotcloud.com 0 -1

# Open http://localhost:8081 and you'll get an error (No Application Configured)
# You need to route www.example.com to this server
```


