[linuxserverurl]: https://linuxserver.io
[appurl]: https://github.com/tautulli/tautulli
[hub]: https://hub.docker.com/r/tautulli/tautulli/

![tautulli](https://raw.githubusercontent.com/Tautulli/Tautulli-Docker/master/img/logo-tautulli-docker.png)

![dockerhubpulls](https://img.shields.io/docker/pulls/tautulli/tautulli.svg)
![dockerhubpulls](https://img.shields.io/docker/stars/tautulli/tautulli.svg)
![dockerhubpulls](https://img.shields.io/docker/build/tautulli/tautulli.svg)

[Tautulli][appurl] integrates with Plex to provide you a feature-rich dashboard of statistics from user activity to a graphical history of streams, play count, along with configurable notifications, and more.

This is the official Tautulli Docker container. Excess packages, dependencies, and base images have been removed to keep the size as small as possible.

This container uses the official [Alpine Linux image](https://hub.docker.com/_/alpine/) as a base image with [s6 overlay](https://github.com/just-containers/s6-overlay).

## Support
Support is available on [Discord](https://tautulli.com/discord), [Reddit](https://www.reddit.com/r/Tautulli), or the [Plex Forums](https://forums.plex.tv/discussion/307821/tautulli-monitor-your-plex-media-server).

## Usage

```
docker create \
  --name=tautulli \
  -v <path to data>:/config \
  -v <path to plexlogs>:/plex_logs:ro \
  -e PGID=<gid> -e PUID=<uid>  \
  -e TZ=<timezone> \
  -p 8181:8181 \
  tautulli/tautulli
```
For shell access while the container is running run `docker exec -it tautulli bash`.

## Parameters

Parameters are split into two halves separated by a colon. The left side represents the host and the right side the container.

**Example**: `-p external:internal` - This shows the port mapping from internal to external of the container.
So `-p 8181:8181` would expose port `8181` from inside the container to be accessible from the host's IP on port `8181`.
`http://<host_ip>:8181` would show you what's running INSIDE the container on port `8181`.

| Parameter | Function |
| :---: | --- |
| `-p 8181` | Port for webui |
| `-v /config` | Contains tautulli config and database |
| `-v /plex_logs` | Map this to [Plex log directory](https://support.plex.tv/articles/200250417-plex-media-server-log-files/) |
| `-e PGID` | GroupID (see below) |
| `-e PUID` | UserID (see below) |
| `-e TZ` | For setting timezone (ex. America/Toronto) |
| `-e ADVANCED_GIT_BRANCH`* | Used to change the build (master/beta**/nightly**) |

\* If this environment variable is not set `master` will be used

**\*\* Note that stability on beta and nightly cannot be guaranteed**

### User / Group Identifiers

When using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. To avoid this issue you can specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```
