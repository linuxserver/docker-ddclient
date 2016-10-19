FROM lsiobase/alpine
MAINTAINER saarg

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install build time dependencies
RUN \
 apk add --no-cache --virtual=build-dependencies \
	bzip2 \
	curl \
	gcc \
	make \
	tar \
	wget && \

# install runtime dependencies
 apk add --no-cache \
	inotify-tools \
	perl \
	perl-digest-sha1 \
	perl-io-socket-ssl \
	perl-json && \

# install Perl cpan modules not in alpine
 curl -L http://cpanmin.us | perl - App::cpanminus && \
 cpanm JSON::Any && \

# create ddclient user for running ddclient so it doesn't modify permissions of the config file
 useradd -u 931 -U -s /bin/false ddclient && \

# install ddclient
 mkdir -p /tmp/ddclient && \
 curl -o \
 /tmp/ddclient.tar.bz2 -L \
	http://vorboss.dl.sourceforge.net/project/ddclient/ddclient/ddclient-3.8.3/ddclient-3.8.3.tar.bz2 && \
 tar xf /tmp/ddclient.tar.bz2 -C \
 /tmp/ddclient --strip-components=1 && \
 cp /tmp/ddclient/ddclient /usr/bin/ && \

# add runtime folders and change permissions
 mkdir -p /var/cache/ddclient && \
 chown ddclient:ddclient /var/cache/ddclient && \
 mkdir -p /var/run/ddclient && \
 chown ddclient:ddclient /var/run/ddclient && \



# cleanup
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/config/.cpanm \
	/tmp/*
	
# copy local files
COPY root/ /

# ports and volumes
VOLUME /config
