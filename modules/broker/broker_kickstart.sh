#!/bin/sh
yum install wget vim net-tools -y
wget https://download.oracle.com/java/20/latest/jdk-20_linux-x64_bin.rpm
rpm -ivh jdk-20_linux-x64_bin.rpm
wget https://dlcdn.apache.org/kafka/3.4.0/kafka_2.13-3.4.0.tgz
tar xvf kafka_2.13-3.4.0.tgz