#!/bin/bash
set -ex

dockerhost=$(docker-machine ip $(docker-machine active))

# re-start hubot test-server
docker rm -f hubot-rocketchat || true
docker run --name hubot-rocketchat \
    -e ROCKETCHAT_URL=http://$dockerhost:3000 \
    -e ROCKETCHAT_ROOM='GENERAL' \
    -e LISTEN_ON_ALL_PUBLIC=true \
    -e ROCKETCHAT_USER=bot \
    -e ROCKETCHAT_PASSWORD=bot \
    -e ROCKETCHAT_AUTH=password \
    -e BOT_NAME=bot \
    -e HUBOT_GITHUB_TOKEN \
    -e EXTERNAL_SCRIPTS=hubot-pugme,hubot-diagnostics,hubot-help,hubot-rules \
    -p 8080:8080 \
    -d local/hubot-home-rocketchat

sleep 10
docker logs hubot-rocketchat

# run tests from test folder
./test/ping.sh

docker logs hubot-rocketchat
