#!/bin/bash


# git clone the repo

# cd to the cloned repo directory


docker-compose up -d
# Run sleep.sh

chmod +x sleep.sh

./sleep.sh


# Execute the POST /memes endpoint using curl

curl --location --request POST 'http://localhost:8081/memes' \
--header 'Content-Type: application/json' \
--data-raw '{
"name": "xyz",
"url": "abc.com",
"caption": "This is a meme"
}'


# Execute the GET /memes endpoint using curl

curl --location --request GET 'http://localhost:8081/memes'
