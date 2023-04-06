FROM navsin189/kafka:1.0

WORKDIR /kafka_2.13-3.4.0

# COPY --chmod=755 change_broker_properties.sh /usr/local/bin/
ENV broker_id=1
RUN sed -i "s/broker.id=0/broker.id=${broker_id}/" config/server.properties
RUN sed -i 's/localhost:2181/zookeeper:2181/' config/server.properties

EXPOSE 9092

CMD ["bin/kafka-server-start.sh","config/server.properties" ]