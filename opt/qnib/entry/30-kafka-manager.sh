#!/bin/bash

cat /opt/qnib/kafka/manager/conf/application.conf |sed -e "s/ZK_SERVER/${ZK_SERVER}/" \
  > /opt/kafka-manager/conf/application.conf
