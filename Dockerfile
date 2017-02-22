FROM qnib/uplain-jre8

ENV KM_VER=1.3.0.8 \
    ZOOKEEPER_HOSTS=localhost
RUN apt-get install -y wget nmap \
 && wget -qO /tmp/kafka-manager_${KM_VER}_all.deb https://github.com/qnib/kafka-manager/releases/download/${KM_VER}/kafka-manager_${KM_VER}_all.deb \
 && dpkg -i /tmp/kafka-manager_${KM_VER}_all.deb \
 && rm -f /tmp/kafka-manager_${KM_VER}_all.deb
ADD opt/qnib/kafka/manager/bin/start.sh \
    opt/qnib/kafka/manager/bin/healthcheck.sh \
    /opt/qnib/kafka/manager/bin/
ADD opt/qnib/entry/30-kafka-manager.sh \
    /opt/qnib/entry/
ADD opt/qnib/kafka/manager/conf/application.conf \
    /opt/qnib/kafka/manager/conf/
CMD ["/opt/qnib/kafka/manager/bin/start.sh"]
