#!/bin/bash

cd /opt/kafka-manager/
java -Dconfig.file=./conf/application.conf -Dpidfile.path=/dev/null \
     -jar /opt/kafka-manager/kafka-manager-assembly.jar
