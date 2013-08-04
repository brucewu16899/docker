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

# Export the container
curl -o export.tar  -G http://localhost:4243/containers/c6bfd6da99d3/export 

# Create an image from an export
curl -H 'Content-Type: application/tar' --compressed --data-binary @/tmp/export.tar -m 60 "http://loc
alhost:4243/images/create?fromSrc=-"
{"status":"6de9128f33c7"}
```

