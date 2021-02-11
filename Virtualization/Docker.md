# Docker
<a href="https://iconscout.com/icons/social" target="_blank">Docker Logo Icon</a> on <a href="https://iconscout.com">Iconscout</a>

- [Docker docs](https://docs.docker.com/engine/reference/commandline/dockerd/)

#### Cheat Sheet list
- [Another Docker Cheat Sheet in pdf](https://www.docker.com/sites/default/files/d8/2019-09/docker-cheat-sheet.pdf)

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
| Key/Command | Description |
| ----------- | ----------- |
| docker network ls | List networks |
| docker network create mynet | Create a local network |
| docker run -d --net mynet redis | Attach container 'redis' to a network on start |
| docker network connect mynet myContainer | Connect a running container from a network |
| docker network disconnect mynet myContainer | Disconnect container 'myContainer' from 'mynet' |

