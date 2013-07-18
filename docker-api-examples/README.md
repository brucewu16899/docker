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
curl -H "Content-type: application/tar" --data-binary @webapp.tar http://localhost:4243/build
...
Step 17 : CMD ["node", "/src/index.js"]
 ---> Running in 7c325d0c8b84
 ---> e29f1e430a8e
Successfully built e29f1e430a8e

curl -H "Content-Type: application/json" -d @create.json http://localhost:4243/containers/create
{"Id":"c6bfd6da99d3"}

curl -H "Content-Type: application/json" http://localhost:4243/containers/(id)/start

```
