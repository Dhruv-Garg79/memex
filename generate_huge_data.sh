#!/bin/bash
for i in {1..1000}
do
  echo "Hai $i"
  curl --location --request POST 'http://localhost:8081/memes?name=Dhruv&caption=Hola%20Amigos!&url=https://images.pexels.com/photos/3573382/pexels-photo-3573382.jpeg'
done

