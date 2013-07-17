docker API
---------


```
# List containers
curl -G http://localhost:4243/containers/json

# Should give the same list
docker ps

# Inspect a container
curl -G http://localhost:4243/containers/[ID]/json

# Build a new container
curl -P -H "Content-type: application/tar" --data-binary @webapp.tar http://localhost:4243/build
```
