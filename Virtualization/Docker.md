 # Docker <a href="url"><img src="https://cdn.iconscout.com/icon/free/png-256/social-275-116309.png" align="left" height="48" width="48" ></a>
- [Docker docs](https://docs.docker.com/engine/reference/commandline/dockerd/)
- [Docker Cheat Sheet](https://www.docker.com/sites/default/files/d8/2019-09/docker-cheat-sheet.pdf)
- [Docker Security Cheat Sheet by OWASP](https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/Docker_Security_Cheat_Sheet.md)
- [Run.tpl - script to inspect and generate the `docker run`command that created the container](https://gist.github.com/efrecon/8ce9c75d518b6eb863f667442d7bc679)
  - Syntax `docker inspect --format "$(<run.tpl)" name_or_id_of_running_container`


### Cleanup
````powershell
docker system df
docker image prune --all
docker volume prune
docker system prune -a              # removes all stopped containers, networks not used by at least one container, all build cache and all images without at least one container associated to them.
docker container prune
docker system prune --volumes       #does the trick

````

## Images
| Key/Command | Description |
| ----------- | ----------- |
| docker build --tak mytag | Build an image from Dockerfile in current directory |
| docker build --no-cache | Force rebuild of Docker image |
| docker commit mycontainer myimage | Convert a container to image |
| docker commit gitlab gitlabimage | Convert a container 'gitlab' to 'gitlab' image |
| docker rmi $(docker images -q -f "dangling=true") | Remove all unused images|
| docker image prune -a | Remove all images without at least one container associated to them |

## Debug
| Key/Command | Description |
| ----------- | ----------- |
| docker exec -it myContainer bash | Run another process in running container |
| docker exec -it --user root 2c1292953762 /bin/bash | Enter the container as root user with bash shell |
| dicjer logs -f myContainer | Show live logs of running daemon container |
| docker container logs --tauk 100 web | Print 100 last lines of a containers log |
| docker port myContainer | Show exposed ports of a container |

## General Usage
| Key/Command | Description |
| ----------- | ----------- |
| docker run -d jenkins | Start a container in background |
| docker run -it ubuntu bash | Start an interactive container in bash |
| docker run -it ubuntu sh | Start an interactive container in the Bourne Shell |
| docker run --rm ubuntu bash | Start a container automatically, removed on stop |
| docker run -p 80:80 -d nginx | Export port from a container |
| docker run -p 8080:80 -d nginx | Expose port 8080 to internal port 80 on container |
| docker run --name mydb redis |Start a named container |
| docker start mycontainer | Start a stopped container |
| docker stop mycontainer | Stop a container |
| docker stop $(docker ps -q) | Stop all containers |
| docker run -d label=traefik.backend=jenkins jenkins | Adds metadata to a container |
| docker container kill web | Stop a running container through SIGKILL |

## Manage Containers
| Key/Command | Description |
| ----------- | ----------- |
| docker ps | List running containers |
| docker ps -a | List all containers (running and stopped) |
| docker inspect 38r3riht | Return information on container |
| docker images | List local available images |
| docker rm $(docker ps --filter status=exited -q) | Delete all stopped containers |
| docker ps --filter label=traefik.backend | List all containers with specific label 'traefik.backend' |
| docker inspect -f '{{.NetworkSettings.IPAddress}}' container | Query a specific metadata of a running container |

## Network
- [How to fix the Docker and UFW security flaw](https://www.techrepublic.com/article/how-to-fix-the-docker-and-ufw-security-flaw/)
- [What is the best practice of docker + ufw under Ubuntu](https://stackoverflow.com/questions/30383845/what-is-the-best-practice-of-docker-ufw-under-ubuntu)
- _Docker actually bypasses UFW and directly alters iptables, such that a container can bind to a port. This means all those UFW rules you have set won't apply to Docker containers_
- Edit the file `/etc/default/docker` and add `DOCKER_OPTS="--iptables=false"`. Restart service: `sudo systemctl restart docker`

| Key/Command | Description |
| ----------- | ----------- |
| docker network ls | List networks |
| docker network create mynet | Create a local network |
| docker run -d --net mynet redis | Attach container 'redis' to a network on start |
| docker network connect mynet myContainer | Connect a running container from a network |
| docker network disconnect mynet myContainer | Disconnect container 'myContainer' from 'mynet' |



##### Credit
- <a href="https://iconscout.com/icons/social" target="_blank">Docker Logo Icon</a> on <a href="https://iconscout.com">Iconscout</a>
