# Alpine Vowpal Wabbit
A reasonably small Alpine based Vowpal Wabbit as a service container.

### What?

I'm not entire sure what Vowpal Wabbit does but this is a container that does it.

### How?

There one assumption in this container, that you have a datafile to read with the `vw -i [filename]` set but this can be overriden (shown later).

The simpliest is to have a dockerfile as such:

```
FROM cheggwpt/alpine-vowpal-wabbit:latest

ENV VOWPAL_WABBIT_DATAFILE /app/mydatafile.vw
ENV VOWPAL_WABBIT_PORT 4000

COPY ./mydatafile.wb /app
```
This will start a container that uses `mydatafile.vw` as a ?source? file and start listening for traffic on port 4000.

The container uses the following to start the `vw` service: 
```
vw -i ${VOWPAL_WABBIT_DATAFILE} --port ${VOWPAL_WABBIT_PORT} --loss_function logistic --link logistic --daemon --foreground
```

And you can override this by setting your own `CMD` line in your Dockerfile as such:

```
FROM cheggwpt/alpine-vowpal-wabbit:latest

ENV VOWPAL_WABBIT_DATAFILE /app/mydatafile.vw
ENV VOWPAL_WABBIT_PORT 4000

COPY ./mydatafile.wb /app

CMD vw -i ${VOWPAL_WABBIT_DATAFILE} --port ${VOWPAL_WABBIT_PORT} --loss_function logistic --link logistic --daemon --foreground
```
**Good Luck!**


### Some Docker Shortcuts

Build this container:

```
docker build -t vw-test .
```

Run it **detached**, remove it when finished:

```
docker run -p 4000:4000 --name vw-test-run --rm -id vw-test
```

Run it **attached**, remove it when finished:

```
docker run -p 4000:4000 --name vw-test-run --rm -id vw-test
```

Run a shell instead, attached, remove it when finished:

```
docker run -p 4000:4000 --name vw-test-run --rm -id vw-test /bin/sh
```

Test the VW Daemon:

```
echo " abc-example| a b c" | nc localhost 4000
```

Connect to a running container:

```
docker exec -it vw-test-run /bin/sh
```

See and follow logs of a detached running container:

```
docker logs -f vw-test-run
```

Stop a running container:

```
docker kill vw-test-run
```

Remove the container (incase you didn't use `--rm` in your run):

```
docker rm vw-test-run
```
