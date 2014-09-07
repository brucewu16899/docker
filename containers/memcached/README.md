memcached docker image
======================

Build with: `docker build --rm -t memcached .`

Run the container interactive mode for testing purposes : 
`docker run -d -p 11211:11211 --name memcached memcached`.

Test that things is running. `[IP]` is the IP adress of the docker server:

	>telnet [IP] 11211
	>add mykey 0 900 2
	>
	>
	>STORED
	>set mykey 0 60 5
	>999
	>
	>STORED
	>get mykey
	>999
	>
	>END
	>quit



