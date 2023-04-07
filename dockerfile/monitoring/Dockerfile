FROM alpine:3.17.3

RUN wget https://github.com/prometheus/prometheus/releases/download/v2.39.1/prometheus-2.39.1.linux-amd64.tar.gz

RUN tar -xvf prometheus-2.39.1.linux-amd64.tar.gz && rm -f prometheus-2.39.1.linux-amd64.tar.gz

WORKDIR /prometheus-2.39.1.linux-amd64

EXPOSE 9090

COPY prometheus_kickstart.sh .

CMD ["sh","prometheus_kickstart.sh"]