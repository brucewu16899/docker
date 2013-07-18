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


