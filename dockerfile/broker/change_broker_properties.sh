#!/bin/sh
broker_id=`echo $broker_id`
sed -i "s/broker.id=0/broker.id=${broker_id}/" config/server.properties
sed -i 's/localhost:2181/zookeeper:2181/' config/server.properties

bin/kafka-server-start.sh config/server.properties