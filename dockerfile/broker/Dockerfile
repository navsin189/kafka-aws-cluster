FROM navsin189/kafka:1.0

WORKDIR /kafka_2.13-3.4.0

COPY change_broker_properties.sh .

EXPOSE 9092

CMD ["sh","change_broker_properties.sh"]