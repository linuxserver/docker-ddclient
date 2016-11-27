FROM lsiobase/alpine
MAINTAINER saarg

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# package versions
ARG DDCLIENT_VER="3.8.3"

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

# install ddclient
 mkdir -p \
	/tmp/ddclient && \
 curl -o \
 /tmp/ddclient.tar.bz2 -L \
	"http://vorboss.dl.sourceforge.net/project/ddclient/ddclient/ddclient-${DDCLIENT_VER}/ddclient-${DDCLIENT_VER}.tar.bz2" && \
 tar xf \
 /tmp/ddclient.tar.bz2 -C \
	/tmp/ddclient --strip-components=1 && \
 install -Dm755 /tmp/ddclient/ddclient /usr/bin/ && \

# cleanup
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/config/.cpanm \
	/root/.cpanm \
	/tmp/*

# copy local files
COPY root/ /

# ports and volumes
VOLUME /config
