![https://linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io](https://forum.linuxserver.io)
* [IRC](https://www.linuxserver.io/irc/) on freenode at `#linuxserver.io`
* [Podcast](https://www.linuxserver.io/podcast/) covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/ddclient

[DDClient](https://sourceforge.net/p/ddclient/wiki/Home/) is a Perl client used to update dynamic DNS entries for accounts on Dynamic DNS Network Service Provider. It was originally written by Paul Burry and is now mostly by wimpunk. It has the capability to update more than just dyndns and it can fetch your WAN-ipaddress in a few different ways. 

[![ddclient](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/ddclient.png)][ddclienturl]
[ddclienturl]: https://sourceforge.net/p/ddclient/wiki/Home/
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



* `-p 1234` - the port(s)
* `-v /config` - explain what lives here
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

Edit the ddclient.conf file found in your /config volume. This config file have many providers to choose from and you basically just have to uncomment your provider and add username/password where requested. If you modify ddclient.conf, ddclient will automaticcaly restart and read the config.

## Info

* Shell access whilst the container is running: `docker exec -it ddclient /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f ddclient`

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' ddclient`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' ddclient`

## Versions

+ **10.02.2017:** Rebase to alpine 3.5.
+ **26.11.2016:** Update README to new standard and add icon and other small details.
+ **29.08.2016:** Initial release.

## Credits

Icon made by [Freepik](http://www.flaticon.com/authors/freepik) from [www.flaticon.com](http://www.flaticon.com) is licensed by [CC 3.0 BY](http://creativecommons.org/licenses/by/3.0/)
