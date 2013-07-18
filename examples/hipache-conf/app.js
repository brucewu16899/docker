var redis = require("redis"),
    client = redis.createClient();

client.on("error", function (err) {
    console.log("Error " + err);
});

client.on("connect", function () {
    client.set("foo_rand000000000000", "some fantastic value", redis.print);
    client.get("foo_rand000000000000", redis.print);

    client.rpush("frontend:www.dotcloud.com", "mywebsite", redis.print);
    client.rpush("frontend:www.dotcloud.com", "http://192.168.0.42:8080", redis.print);
    client.lrange("frontend:www.dotcloud.com", 0,-1, redis.print);

});
