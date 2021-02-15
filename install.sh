#!/bin/bash

#install node
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install -y nodejs build-essential


# install docker
chmod +x docker_install.sh
./docker_install.sh

# run docker postgress server
docker run --name post -p 5432:5432 -e POSTGRES_PASSWORD=password -e POSTGRES_USER=meme -d postgres:alpine

sleep 2
