#!/bin/bash
set -ex

# restart rocket chat server if it is already running
docker rm -f rocketchat || true

# ingore db restart if it is already running
docker rm -f db || true
mkdir -p /data/chatops_db || true
#sudo chmod -R 777 /data/chatops_db
docker run --name db -v /data/chatops_db:/data/db -d mongo mongod || true
docker start db || true

# start rockerchat
docker run --name rocketchat \
     -p 3000:3000 \
     --link db \
     -d local/docker-home-rocketchat

