var redis = require("redis"),
    redis_client = redis.createClient();

redis_client.on("error", function (err) {
    console.log("Error " + err);
});

redis_client.on("connect", function () {
    redis_client.set("foo_rand000000000000", "some fantastic value", redis.print);
    redis_client.get("foo_rand000000000000", redis.print);

    redis_client.del("frontend:www.dotcloud.com", redis.print);

    redis_client.rpush("frontend:www.dotcloud.com", "mywebsite", redis.print);
    redis_client.rpush("frontend:www.dotcloud.com", "http://192.168.0.42:8080", redis.print);
    redis_client.lrange("frontend:www.dotcloud.com", 0,-1, redis.print);

    redis_client.keys("*", redis.print);

    redis_client.keys("*", function(keys) {

            helpers.logDebug('_proxyStatus: redis keys - ' + keys);

            for(key in keys) {
                redis_client.lrange(key, 0,-1, redis.print);
            }
   });

    redis_client.del("frontend:www.dotcloud.com", redis.print);

});
