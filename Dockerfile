FROM qnib/uplain-sbt:0.13.9 as build

ARG KM_VER=1.3.3.7

RUN apt-get update \
 && apt-get install -y wget \
 && wget -qO - https://github.com/yahoo/kafka-manager/archive/${KM_VER}.tar.gz |tar xfz - -C /opt/ \
 && mv /opt/kafka-manager-${KM_VER} /opt/kafka-manager \
 && cd /opt/kafka-manager \
 && sbt clean dist

FROM qnib/alplain-openjre8
ENV ZOOKEEPER_HOSTS=localhost

COPY --from=build /opt/kafka-manager/target/scala-2.11/* /opt/kafka-manager/
COPY --from=build /opt/kafka-manager/bin /opt/kafka-manager/
COPY --from=build /opt/kafka-manager/conf /opt/kafka-manager/
COPY opt/qnib/kafka/manager/bin/start.sh \
    opt/qnib/kafka/manager/bin/healthcheck.sh \
    /opt/qnib/kafka/manager/bin/
ADD opt/qnib/entry/30-kafka-manager.sh \
    /opt/qnib/entry/
ADD opt/qnib/kafka/manager/conf/application.conf \
    /opt/qnib/kafka/manager/conf/
CMD ["/opt/qnib/kafka/manager/bin/start.sh"]
