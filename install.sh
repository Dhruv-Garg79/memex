#!/bin/bash

# install docker
chmod +x docker_install.sh
./docker_install.sh

# run docker postgress server
docker run --name post -p 5432:5432 -e POSTGRES_PASSWORD=password -e POSTGRES_USER=meme -d postgres:alpine

sleep 2
