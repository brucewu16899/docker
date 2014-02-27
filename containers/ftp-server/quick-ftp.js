var Server = require('quick-ftp');

var myFtp = new Server();

myFtp.on('stdout', function(data) {
  console.log(data);
});

myFtp.on('stderr', function(data) {
  console.log('ERROR', data);
})

myFtp.init({
  user: "sergi",
  pass: "1234",
  port: "3334"
});

