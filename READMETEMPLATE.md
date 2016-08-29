![https://linuxserver.io](https://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io](https://forum.linuxserver.io)
* [IRC](https://www.linuxserver.io/index.php/irc/) on freenode at `#linuxserver.io`
* [Podcast](https://www.linuxserver.io/index.php/category/podcast/) covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/ddclient

DDclient is a Perl client used to update dynamic DNS entries for accounts on Dynamic DNS Network Service Provider. It was originally written by Paul Burry and is now mostly by wimpunk. It has the capability to update more than just dyndns and it can fetch your WAN-ipaddress in a few different ways. 


## Usage

```
docker create \
  --name=ddclient \
  -v <path to data>:/config \
  -e PGID=<gid> -e PUID=<uid>  \
  linuxserver/docker-ddclient
```

**Parameters**

* `-p 1234` - the port(s)
* `-v /config` - explain what lives here
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it tvheadend-unstable /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

Edit the ddclient.conf file found in your /config volume. This config file have many providers to choose from and you basically just have to uncomment your provider and add username/password where requested. If you modify ddclient.conf, ddclient will automaticcaly restart and read the config.

## Info

* Shell access whilst the container is running: `docker exec -it tvheadend-unstable /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f tvheadend-unstable`

## Versions

+ **29.08.2016:** Initial release.
