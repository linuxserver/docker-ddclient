[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring :-

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [IRC](https://irc.linuxserver.io) - on freenode at `#linuxserver.io`. Our primary support channel is Discord.
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!

# [linuxserver/ddclient](https://github.com/linuxserver/docker-ddclient)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/ddclient.svg)](https://microbadger.com/images/linuxserver/ddclient "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/ddclient.svg)](https://microbadger.com/images/linuxserver/ddclient "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/ddclient.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/ddclient.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-ddclient/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-ddclient/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/ddclient/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/ddclient/latest/index.html)

[Ddclient](https://sourceforge.net/p/ddclient/wiki/Home/) is a Perl client used to update dynamic DNS entries for accounts on Dynamic DNS Network Service Provider. It was originally written by Paul Burry and is now mostly by wimpunk. It has the capability to update more than just dyndns and it can fetch your WAN-ipaddress in a few different ways.

[![ddclient](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/ddclient-logo.png)](https://sourceforge.net/p/ddclient/wiki/Home/)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/). 

Simply pulling `linuxserver/ddclient` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v7-latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=ddclient \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -v <path to data>:/config \
  --restart unless-stopped \
  linuxserver/ddclient
```


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  ddclient:
    image: linuxserver/ddclient
    container_name: ddclient
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
    volumes:
      - <path to data>:/config
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London. |
| `-v /config` | Where ddclient should store its config files. |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```


&nbsp;
## Application Setup

Edit the ddclient.conf file found in your /config volume. This config file has many providers to choose from and you basically just have to uncomment your provider and add username/password where requested. If you modify ddclient.conf, ddclient will automaticcaly restart and read the config.



## Support Info

* Shell access whilst the container is running: `docker exec -it ddclient /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f ddclient`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' ddclient`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/ddclient`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.  
  
Below are the instructions for updating containers:  
  
### Via Docker Run/Create
* Update the image: `docker pull linuxserver/ddclient`
* Stop the running container: `docker stop ddclient`
* Delete the container: `docker rm ddclient`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start ddclient`
* You can also remove the old dangling images: `docker image prune`

### Via Taisun auto-updater (especially useful if you don't remember the original parameters)
* Pull the latest image at its tag and replace it with the same env variables in one shot:
  ```
  docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock taisun/updater \
  --oneshot ddclient
  ```
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull ddclient`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d ddclient`
* You can also remove the old dangling images: `docker image prune`

## Versions

* **23.03.19:** - Switching to new Base images, shift to arm32v7 tag.
* **10.03.19:** - Add perl-io-socket-inet6 for ipv6 support.
* **22.02.19:** - Rebasing to alpine 3.9.
* **11.02.19:** - Add pipeline logic and multi arch.
* **22.08.18:** - Rebase to alpine 3.8.
* **10.08.18:** - Update to ddclient v3.9.0. For Cloudflare users, please ensure you remove the line `server=www.cloudflare.com` from your `ddclient.conf`.
* **07.12.17:** - Rebase to alpine 3.7.
* **28.05.17:** - Rebase to alpine 3.6.
* **10.02.17:** - Rebase to alpine 3.5.
* **26.11.16:** - Update README to new standard and add icon and other small details.
* **29.08.16:** - Initial release.
