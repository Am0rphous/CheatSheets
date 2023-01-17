#!/bin/bash
# Am0rphous 18.08.21
# updates gitlab in docker

echo Starts in 3 seconds.
echo ""
for number in 3 2 1
  do
     echo $number
     sleep 1
  done

echo "Downloads latests gitlab-version ... "
docker pull gitlab/gitlab-ce:latest

echo "Stopping and removing the old container ... "
docker stop gitlab-container && docker rm gitlab-container

echo "Starting new container ... "
#It's important that we 'cd' into the location where the yaml file is located.

cd compose
docker-compose up -d -f /srv/compose/gitlab/docker-compose.yaml
echo "Done!"
echo ""

docker ps
