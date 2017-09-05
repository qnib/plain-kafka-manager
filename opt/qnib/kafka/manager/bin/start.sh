#!/bin/bash

cd /opt/kafka-manager/
java -Dconfig.file=./conf/application.conf \
     -jar /opt/kafka-manager/kafka-manager-assembly.jar
