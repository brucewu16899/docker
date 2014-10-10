/*jshint -W054, evil:true, devel:true, browser:true*/

//
// Unit tests 
//
// Run like this:
// >nodeunit test.js
//
// NOTE: THIS TESTS HAVE NOT BEEN COMPLETED, TESTING FROM COMMAND LINE WITH DIG

/*
  ======== A Handy Little Nodeunit Reference ========
  https://github.com/caolan/nodeunit

  Test methods:
    test.expect(numAssertions)
    test.done()
  Test assertions:
    test.ok(value, [message])
    test.equal(actual, expected, [message])
    test.notEqual(actual, expected, [message])
    test.deepEqual(actual, expected, [message])
    test.notDeepEqual(actual, expected, [message])
    test.strictEqual(actual, expected, [message])
    test.notStrictEqual(actual, expected, [message])
    test.throws(block, [error], [message])
    test.doesNotThrow(block, [error], [message])
    test.ifError(value)
*/

/*		
		EXMAPLE OF ASYNC TESTS

		var redis        = require("redis"),
			redis_client = redis.createClient(),
			dns          = require('dns'),
			domain       = 'redis-dns.local',
			ip           = '123.456.789.012';

		// There should be X tests
		test.expect(1);

		// tests here
		redis_client.on("connect", function () {

			// first set the IP for the domain in redis
			redis_client.set("redis-dns:"+domain, ip, function(err, res) {
				redis_client.quit();

				// Now check if the expected answer
				dns.resolve4(domain, function (err, addresses) {
					if (err) {
						throw err;
					}

					test.equal(addresses[0], ip, 'logDebug');

					console.log('addresses: ' + JSON.stringify(addresses));

					// All tests performed
					test.done();

				});
			}.bind(this));
		}.bind(this));

		// redis error management
		redis_client.on("error", function (err) {
			console.log("Redis error: " + err);
		});
*/

// Unit test
//-------------------------------------------------------------------------------------------------
// Basic tests for redis-dns

exports['test_odatamysql'] = {

	setUp: function(done) {

		// IMPORTANT: UPDATE THIS IP ADDRESS BEFORE RUNNING THE TESTS
		this.IP = '192.168.59.103';


		// setup here
		this.mysqlodata = require('../src/main.js');

		// Incorrect URLs
		this.ic = [];
		this.ic.push('http://localhost/xyz/schema/table?$select=col1,col2&$filter=co1 eq "help"&$orderby=col2');
		this.ic.push('http://localhost/schema/table(2)');

		// Correct URLs
		this.c = [];
		this.c.push('http://localhost/schema/table?$select=col1,col2&$filter=co1 eq "help"&$orderby=col2&$skip=10');
		this.c.push('http://localhost/schema/table');
		this.c.push('http://localhost/schema/table?$select=col1,col2&$filter=Price add 5 gt 10&$orderby=col2');

		// setup finished
		done();
	},

	'testing mysqlodata.parseQuery': function(test) {

		var expected = [];
		expected.push('{"schema":"schema","sql":"select col1,col2 from table where co1 = \\"help\\" order by col2 limit 10,100"}');
		expected.push('{"schema":"schema","sql":"select * from table"}');
		expected.push('{"schema":"schema","sql":"select col1,col2 from table where Price + 5 > 10 order by col2"}');


		for (var i=0; i<this.c.length; i++ ) {
		    console.log("url: "+this.c[i]);
		    var o = this.mysqlodata.parseQuery(this.c[i]);

		    test.equal(JSON.stringify(o), 
		    	expected[i],
		    	this.c[i])
		}

		for (var i=0; i<this.ic.length; i++ ) {
		    console.log("url: "+this.ic[i]);
		    try {
		        var o = mysqlodata.parseQuery(this.ic[i]);
		    } catch(e) {
		        console.log('Caugth error just as expected: '+e);
		    }
		}

		test.done();
		
	},

	'testing odata server': function(test) {
		var http = require('http');

		var options = {
			hostname: this.IP,
			port: 80,
			path: '/wp/wp_links',
			method: 'GET',
			headers : { 
				user: 'wp',
				password: 'wp'
			}
		};

		var req = http.request(options, function(res) {
			console.log('STATUS: ' + res.statusCode);
			console.log('HEADERS: ' + JSON.stringify(res.headers));
			res.setEncoding('utf8');

			res.on('data', function (chunk) {
				console.log('BODY: ' + chunk);
			});
		});

		req.on('error', function(e) {
			console.log('problem with request: ' + e.message);
		});

		// write data to request body
//		req.write('data\n');
//		req.write('data\n');
		req.end(); 

		test.done();

	}

};
