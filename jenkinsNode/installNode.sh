#!/bin/bash
export NODE_VERSION=7.9.0
addgroup -g 1000 node 
adduser -u 1000 -G node -s /bin/sh -D node 
apk add --no-cache libstdc++ 
apk add --no-cache --virtual .build-deps \
        binutils-gold \
        curl \
        g++ \
        gcc \
        gnupg \
        libgcc \
        linux-headers \
        make \
        python \

curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION.tar.xz" 
tar -xf "node-v$NODE_VERSION.tar.xz" 
cd "node-v$NODE_VERSION" 
./configure 
make -j$(getconf _NPROCESSORS_ONLN) 
make install 
apk del .build-deps 
cd .. 
rm -Rf "node-v$NODE_VERSION" 
rm "node-v$NODE_VERSION.tar.xz"