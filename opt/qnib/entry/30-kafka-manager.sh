#!/bin/bash

cat /opt/qnib/kafka/manager/conf/application.conf |sed -e "s/ZOOKEEPER_HOSTS/${ZOOKEEPER_HOSTS}/" \
  > /opt/kafka-manager/conf/application.conf
