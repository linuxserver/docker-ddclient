FROM lsiobase/alpine:3.9

# set version label
ARG BUILD_DATE
ARG VERSION
ARG DDCLIENT_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="saarg"

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	bzip2 \
	curl \
	gcc \
	make \
	tar \
	wget && \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	inotify-tools \
	jq \
	perl \
	perl-digest-sha1 \
	perl-io-socket-ssl \
	perl-json && \
 echo "***** install perl modules ****" && \
 curl -L http://cpanmin.us | perl - App::cpanminus && \
 cpanm \
	Data::Validate::IP \
	JSON::Any && \
 echo "**** install ddclient ****" && \
 if [ -z ${DDCLIENT_VERSION+x} ]; then \
	DDCLIENT_VERSION=$(curl -sL 'http://sourceforge.net/projects/ddclient/best_release.json' \
	| jq -r '.platform_releases.linux.filename' | awk -F '(ddclient-|.zip)' '{print $3}'); \
 fi && \
 mkdir -p \
	/tmp/ddclient && \
 curl -o \
 /tmp/ddclient.tar.gz -L \
	"https://sourceforge.net/projects/ddclient/files/ddclient/ddclient-${DDCLIENT_VERSION}/ddclient-${DDCLIENT_VERSION}.tar.gz/download" && \
 tar xf \
 /tmp/ddclient.tar.gz -C \
	/tmp/ddclient --strip-components=1 && \
 install -Dm755 /tmp/ddclient/ddclient /usr/bin/ && \
 echo "**** cleanup ****" && \
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
