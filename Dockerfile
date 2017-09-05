ARG DOCKER_REGISTRY=docker.io
# 0.13.15
FROM ${DOCKER_REGISTRY}/qnib/alplain-openjdk8-sbt@sha256:26fa55ac0ad9af462a86615bfe8ffde6c2d71f4011d54c3ae959024c90a091d3 as build

ARG KM_VER=1.3.3.13
ARG SCALA_VER=2.11
RUN apk --no-cache add wget \
 && wget -qO- https://github.com/yahoo/kafka-manager/archive/${KM_VER}.tar.gz |tar xfz - -C /opt/ \
 && mv /opt/kafka-manager-${KM_VER} /opt/kafka-manager
RUN cd /opt/kafka-manager/ \
 && sbt 'set test in assembly := {}' clean assembly

FROM ${DOCKER_REGISTRY}/qnib/alplain-openjre8-prometheus@sha256:c4e53e441eeff6f8e31988a17938784af84af159f529d3459de1f167b197cf1f
ARG KM_VER=1.3.3.13
ARG SCALA_VER=2.11
LABEL kafka-manager.version=${SCALA_VER}-${KM_VER}
ENV ZOOKEEPER_HOSTS=localhost \
    ENTRYPOINTS_DIR=/opt/qnib/entry
COPY --from=build /opt/kafka-manager/target/scala-${SCALA_VER}/kafka-manager-assembly-${KM_VER}.jar /opt/kafka-manager/kafka-manager-assembly.jar
COPY --from=build  /opt/kafka-manager/conf/ /opt/kafka-manager/conf/
COPY opt/qnib/kafka/manager/bin/start.sh \
    opt/qnib/kafka/manager/bin/healthcheck.sh \
    /opt/qnib/kafka/manager/bin/
COPY opt/qnib/entry/30-kafka-manager.sh \
    /opt/qnib/entry/
COPY opt/qnib/kafka/manager/conf/application.conf \
    /opt/qnib/kafka/manager/conf/
CMD ["/opt/qnib/kafka/manager/bin/start.sh"]
