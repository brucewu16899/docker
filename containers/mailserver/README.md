Mail server as a Docker image
============================

This is a Dockerfile to get a Postfix mail server.

First create `Dockerfile` by copying `Dockerfile.template`

Then create `main.cf` by copying `main.cf.template` and update the domains settings.

Many mail servers don't accept incoming connections from IP-adresses
from virtual machines. A smarthost needs to be used in these cases. This
image therefore requires an account at Google. 

Update `USERNAME` and `PASSWORD` in this row in the Dockerfile: 
`run echo smtp.gmail.com USERNAME:PASSWORD > /etc/postfix/relay_passwd`

Then build with: `docker build --rm -t postfix .`

Test to send a message from within the container: 

	>docker run -t -i --rm postfix /bin/bash
	>/start.sh &
	>su - someone
	>echo "This is a mail test message" |mutt -s "Test message" jonas@gizur.com
	>exit


Now start a container and map the smtp port: `docker run -d -p 25:25 --name postfix postfix`

Check the logs: `docker logs postfix`

See `test/README.md` for instructions on howto send a testmail.

