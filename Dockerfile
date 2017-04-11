FROM qnib/alplain-openjre8

ARG KM_VER=1.3.3.4
ENV ZOOKEEPER_HOSTS=localhost

RUN apk --no-cache add wget nmap \
 && wget -qO /tmp/kafka-manager.zip https://github.com/qnib/kafka-manager/releases/download/${KM_VER}/kafka-manager-${KM_VER}.zip \
 && cd /opt/ \
 && unzip /tmp/kafka-manager.zip \
 && mv /opt/kafka-manager-${KM_VER} /opt/kafka-manager \
 && rm -f /tmp/kafka-manager*
ADD opt/qnib/kafka/manager/bin/start.sh \
    opt/qnib/kafka/manager/bin/healthcheck.sh \
    /opt/qnib/kafka/manager/bin/
ADD opt/qnib/entry/30-kafka-manager.sh \
    /opt/qnib/entry/
ADD opt/qnib/kafka/manager/conf/application.conf \
    /opt/qnib/kafka/manager/conf/
CMD ["/opt/qnib/kafka/manager/bin/start.sh"]
