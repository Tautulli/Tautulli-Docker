FROM lsiobase/alpine.python:3.6
MAINTAINER sparklyballs
# Forked from https://github.com/linuxserver/docker-plexpy

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Tautulli version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install packages
RUN \
 apk add --no-cache --virtual=build-dependencies \
	g++ \
	gcc \
	make \
	python-dev && \

# install pycryptodomex Pillow Plexapi
 pip install --no-cache-dir -U \
	pycryptodomex Pillow plexapi && \

# cleanup
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/root/.cache

# add local files
COPY root/ /

# ports and volumes
VOLUME /config /logs
EXPOSE 8181
