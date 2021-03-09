FROM ghcr.io/linuxserver/baseimage-alpine:3.12

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
	gcc \
	make \
	tar \
	wget && \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	bind-tools \
	curl \
	inotify-tools \
	jq \
	perl \
	perl-digest-sha1 \
	perl-io-socket-inet6 \
	perl-io-socket-ssl \
	perl-json && \
 echo "***** install perl modules ****" && \
 curl -L http://cpanmin.us | perl - App::cpanminus && \
 cpanm \
	Data::Validate::IP \
	JSON::Any && \
 echo "**** install ddclient ****" && \
 if [ -z ${DDCLIENT_VERSION+x} ]; then \
	DDCLIENT_VERSION=$(curl -sX GET "https://api.github.com/repos/ddclient/ddclient/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]'); \
 fi && \
 mkdir -p \
	/tmp/ddclient && \
 curl -o \
 /tmp/ddclient.tar.gz -L \
	"https://github.com/ddclient/ddclient/archive/${DDCLIENT_VERSION}.tar.gz" && \
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
