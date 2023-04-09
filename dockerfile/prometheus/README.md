# Prometheus Docker Image

## Version 2.0

- Prometheus image is now available on docker hub.
- To monitor containers [cadvisor](https://github.com/google/cadvisor).
- [Prometheus with cadvisor](https://prometheus.io/docs/guides/cadvisor/).

```
docker run \
  --volume=/:/rootfs:ro \
  --volume=/var/run:/var/run:ro \
  --volume=/sys:/sys:ro \
  --volume=/var/lib/docker/:/var/lib/docker:ro \
  --volume=/dev/disk/:/dev/disk:ro \
  --publish=8080:8080 \
  --detach=true \
  --name=cadvisor \
  --network kafka \
  --device=/dev/kmsg \
  gcr.io/cadvisor/cadvisor:$VERSION

docker run -dit -p 9090:9090 --network kafka -e JOBS="cadvisor@cadvisor:8080" --name prometheus navsin189/prometheus:1.0
```

- CAdvisor provides a web UI used to stats of containers on http://localhost:8080/docker/
- Prometheus WEB UI on http://localhost:9090/graph
- [Query language used for containers in prometheus](https://prometheus.io/docs/guides/cadvisor/#other-expressions)

```
rate(container_cpu_usage_seconds_total{name="container_name"}[1m])
container_memory_usage_bytes{name="redis"}
rate(container_network_transmit_bytes_total[1m])
rate(container_network_receive_bytes_total[1m])
```

## Version 1.0

Prometheus is a monitoring tool which monitor your target machine health and other parameter such as free RAM, CPU utilization, network and etc.For more visit:

- [Official Documentation](https://prometheus.io/docs/introduction/overview/)
- [Prometheus with Grafana](https://blog.devops.dev/prometheus-with-grafana-556efd23a9d6)

> Prometheus works on pull based mechanism that there should be an exporter on target machine that generates the metrics then Prometheus pull the metrics using REST(over HTTP).

### Custom Script

- `prometheus_kickstart.sh` is used to update the config file of prometheus for target nodes.
- It reads the **environmental variable called JOBS** and take the value to proceed further.

```
JOBS="job_name@ip1:port1 job_name@ip2:port2 job_name@ip3:port3"
# each job is separated by a space

```

- after update it start the server.

### Docker run Command

```
# A custom network is required for working.
docker network create kafka # run this if not created

docker build -t prometheus:1.0 .

docker run -dit -p 9090:9090 --network kafka -e JOBS="zookeeper@${zookeeper_container_name}:2181 broker1@${broker1_container_name}:${broker1_port} broker2@${broker2_container_name}:${broker2_port}" --name prometheus prometheus:1.0
```
