## zookeeper Docker Image

- custom kafka image as base
- starting zookeeper server at port 2181

```
docker build -t zookeeper:1.0 .

# A custom network is required for working.
docker network create kafka # run this if not created

docker run -dit --network kafka -p 2181:2181 --name zookeeper zookeeper:1.0
```
