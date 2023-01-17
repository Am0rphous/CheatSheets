# Runners

Update a Gitlab Runner in Docker:
````
#!/bin/bash
# Am0rphous 18.08.21

#https://docs.gitlab.com/runner/install/docker.html
#docker pull gitlab/gitlab-runner:latest

echo Starting in 3 seconds..
echo ""
for number in 3 2 1
  do
     echo $number
     sleep 1
  done

#gitlab-runner config is in a volum named 'gitlab-runner-config'
#docker volume inspect gitlab-runner-config
#the config is in: /var/lib/docker/volumes/gitlab-runner-config/_data/config.toml

for number in 1 2 3 4 5 6
  do
    echo "Stopping runner $number ... "
      docker stop gitlab-runner$number && docker rm gitlab-runner$number
      echo "Starting new runner ... "
      docker run -d --name gitlab-runner$number --restart always \
         -v /var/run/docker.sock:/var/run/docker.sock \
         -v gitlab-runner-config:/etc/gitlab-runner \
         gitlab/gitlab-runner:latest
      echo "Finishing Gitlab-Runner $number ..."
      echo ""
    done
exit 0

````
