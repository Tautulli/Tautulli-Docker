[linuxserverurl]: https://linuxserver.io
[appurl]: https://github.com/tautulli/tautulli
[hub]: https://hub.docker.com/r/tautulli/tautulli/

![tautulli](https://raw.githubusercontent.com/Tautulli/Tautulli-Docker/master/img/logo-tautulli-docker.png)

![dockerhubpulls](https://img.shields.io/docker/pulls/tautulli/tautulli.svg)
![dockerhubpulls](https://img.shields.io/docker/stars/tautulli/tautulli.svg)
![dockerhubpulls](https://img.shields.io/docker/build/tautulli/tautulli.svg)

This docker is based on [LinuxServer.io][linuxserverurl] containers.

[Tautulli][appurl] integrates with Plex to provide you a feature-rich dashboard of statistics from user activity to a graphical history of streams, play count, along with configurable notifications, and more.

This docker integrates the [plexapi](https://github.com/pkkid/python-plexapi) python package for use with scripts.


## Usage

```
docker create \
  --name=tautulli \
  -v <path to data>:/config \
  -v <path to plexlogs>:/logs:ro \
  -e PGID=<gid> -e PUID=<uid>  \
  -e TZ=<timezone> \
  -p 8181:8181 \
  tautulli/tautulli
```

## Parameters

The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side.
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.


* `-p 8181` - Port for webui
* `-v /config` Containes plexpy config and database
* `-v /logs` Map this to the Plex Media Server log directory
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` for setting timezone information, eg Europe/London
* `-e ADVANCED_GIT_BRANCH` used to change the git branch used by the container

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it plexpy /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. To avoid this issue you can specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```
