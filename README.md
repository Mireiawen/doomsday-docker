# Doomsday Engine
Docker Container for the [Doomsday Engine](http://dengine.net/) 

Dockerfile contains the following
- [Bitnami Minideb](https://hub.docker.com/r/bitnami/minideb/) based on [Debian Stretch](https://www.debian.org/)
- Doomsday Engine 2
- Doom shareware WAD

## Running
Run this container with the following options to run a Doom1 Shareware deathmatch inclued in this repository:

```
docker run \
	--rm \
	--tty \
	--publish "13209:13209" \
	"mireiawen/doomsday" \
		-game "doom1-share" \
		-p "/app/configs/autoexec.cfg" \
		-iwad "/app/wads" \
		-stdout
```

Run this container by using a volume mount of the local directory containing a `autoexec.cfg` and WADS

```
docker run \
	--rm \
	--volume "/path/to/wads:/app/wads" \
	--volume "/path/to/config:/app/config" \
	--tty \
	--publish "13209:13209" \
	"mireiawen/doomsday" \
		-game "doom1-share" \
		-p "/app/configs/autoexec.cfg" \
		-iwad "/app/wads" \
		-stdout
```

Update the command line options to meet the game type, port etc. 
See the [Doomsday Multiplayer Server](https://manual.dengine.net/multiplayer/multiplayer_server) 
for additional options and configuration.

To stop a running server, just stop its container. To find the container, you can use `docker ps`
and to actually stop the container you can use `docker stop <container name or id>`

Or as oneliner to stop *all* containers based on this image:
```
docker stop "$(docker 'ps' --filter='ancestor=mireiawen/doomsday' --quiet)"
```
