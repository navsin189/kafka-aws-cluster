## Kafka Docker Image

- took alpine as base
- installed openJDK11
- Downloaded Kafka and extracted it

### This image will the base image of zookeeper and broker.

```
docker build -t kafka:1.0 .

# A custom network is required for working.
docker network create kafka # run this if not created
```
