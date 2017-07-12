[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: https://sourceforge.net/p/ddclient/wiki/Home/
[hub]: https://hub.docker.com/r/linuxserver/ddclient/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/ddclient
[![](https://images.microbadger.com/badges/version/linuxserver/ddclient.svg)](https://microbadger.com/images/linuxserver/ddclient "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/linuxserver/ddclient.svg)](https://microbadger.com/images/linuxserver/ddclient "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/ddclient.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/ddclient.svg)][hub][![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Builders/x86-64/x86-64-ddclient)](https://ci.linuxserver.io/job/Docker-Builders/job/x86-64/job/x86-64-ddclient/)

[DDClient][appurl] is a Perl client used to update dynamic DNS entries for accounts on Dynamic DNS Network Service Provider. It was originally written by Paul Burry and is now mostly by wimpunk. It has the capability to update more than just dyndns and it can fetch your WAN-ipaddress in a few different ways.

[![ddclient]()][appurl]

## Usage

```
docker create \
  --name=ddclient \
  -v <path to data>:/config \
  -e PGID=<gid> -e PUID=<uid>  \
  -e TZ=<Timezone> \
  linuxserver/ddclient
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`



* `-v /config` - Where ddclient should store its config files
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` - for timezone information *eg Europe/London, etc*

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it ddclient /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

Edit the ddclient.conf file found in your /config volume. This config file has many providers to choose from and you basically just have to uncomment your provider and add username/password where requested. If you modify ddclient.conf, ddclient will automaticcaly restart and read the config.

## Info

* Shell access whilst the container is running: `docker exec -it ddclient /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f ddclient`

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' ddclient`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/ddclient`

## Versions

+ **28.05.2017:** Rebase to alpine 3.6.
+ **10.02.2017:** Rebase to alpine 3.5.
+ **26.11.2016:** Update README to new standard and add icon and other small details.
+ **29.08.2016:** Initial release.
