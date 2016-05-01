docker-machine start home-bot-vm || true
docker-machine env home-bot-vm || docker-machine regenerate-certs home-bot-vm
eval $(docker-machine env home-bot-vm)
docker images
docker ps