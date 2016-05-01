#!/bin/bash
set -ex

if ! docker-machine ls | grep "home-bot-vm";
then
  # Create build-vm if it does not exists
  docker-machine --debug create -d virtualbox \
    --virtualbox-memory 4096 \
    --virtualbox-disk-size 20000 \
    home-bot-vm || true
fi


if !  docker-machine ls | grep -e "home-bot-vm.*\*.*Running";
then
  docker-machine start home-bot-vm || true
  docker-machine env home-bot-vm || docker-machine regenerate-certs home-bot-vm
  eval $(docker-machine env home-bot-vm)
  docker images
  docker ps
fi

./build-hubot-rocketchat.sh
./build-docker-rocketchat.sh
