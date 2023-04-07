# Broker Docker Image

## Version 2.0

- Broker image is now available on docker hub.

```
docker run -dit --network kafka -p 9092:9092 -e broker_id=${unique_number} --name broker1 navsin189/broker:1.0
```

## Version 1.0

- custom kafka as base image
- copied a script to run server instead of directly running the kafka server.
- exposed to 9092

### custom script

- The `change_broker_properties.sh` script changes the **broker id** in the server config file
- Every broker should have unique ID.
- It also changes the IP and port in the config.
- **NOTE** - The IP is zookeeper because the container launched for zookeeper has the same name.
- If the zookeeper's container name gets changed, the above script needs to be updated.

```
# in change_broker_properties.sh
sed -i 's/localhost:2181/${zookeeper_container_name}:2181/' config/server.properties
```

```
docker build -t broker:1.0 .

# A custom network is required for working.
docker network create kafka # run this if not created

docker run -dit --network kafka -p 9092:9092 -e broker_id=12 --name broker1 broker:1.0
```
