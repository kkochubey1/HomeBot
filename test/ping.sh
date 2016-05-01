#!/bin/bash
set -ex
dockerhost=$(docker-machine ip $(docker-machine active))
curl -X POST http://$dockerhost:8080/hubot/github-listener/GENERAL -H "content-type: application/json" -H "X-GitHub-Event: ping" -d @${BASH_SOURCE%/*}/ping.json