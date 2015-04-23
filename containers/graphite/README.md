batches in supervisord
======================

Build with: `docker build --rm -t supervisord .`

Run the container interactive mode for testing purposes :
`docker run -t -i --rm graphite /bin/bash`.

```
docker run -t -i -p 81:80 -p 444:443 --restart="on-failure:10" \
--link beservices:beservices --name=graphite -h graphite \
graphite /bin/bash -c "supervisord; bash"
```
