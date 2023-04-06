## Prerequisite

- create a custom network called kafka.
- launch all container in this network

```
docker network create kafka

docker run -dit --network kafka -p ${host_port}:${container_port} -e ENV_NAME=env_value \
 --name ${unique_container_name} ${image_name}:${version}
```

## docker cheat sheet

```
docker images

docker rmi image_name:version
```

```
docker run [options] image
```

```
docker ps

docker ps -a

docker rm container_name
```

```
docker start container_name

docker stop container_name

docker exec container_name command

docker logs container_name

docker inspect container_name
```

```
docker network create network_name

docker network inspect network_name
```
