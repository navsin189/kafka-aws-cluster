FROM alpine:3.17.3

RUN apk add openjdk11 bash

RUN wget https://dlcdn.apache.org/kafka/3.4.0/kafka_2.13-3.4.0.tgz && tar xvf kafka_2.13-3.4.0.tgz && rm -f kafka_2.13-3.4.0.tgz

WORKDIR /kafka_2.13-3.4.0

CMD ["echo", "SETUP DONE"]