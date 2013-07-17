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

curl -H "Content-Type: application/json" http://localhost:4243/containers/create -d '{ "Hostname":"", "User":"", "Memory":0, "MemorySwap":0, "AttachStdin":false, "AttachStdout":true, "AttachStderr":true, "PortSpecs":null, "Tty":false, "OpenStdin":false, "StdinOnce":false, "Env":null, "Cmd":[ "date" ], "Dns":null, "Image":"e29f1e430a8e", "Volumes":{}, "VolumesFrom":" }'

```
