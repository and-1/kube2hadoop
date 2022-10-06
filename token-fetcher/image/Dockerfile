FROM openjdk:8u181-jdk as builder

COPY . /apps

WORKDIR /apps

RUN ./gradlew build

FROM openjdk:8u181-jre

COPY misc/start_hadoop2kube.sh /hadoop2kube.sh
COPY token-fetcher/resources/log4j.properties /kube2hadoop/conf/log4j.properties
COPY core/src/resources/kube2hadoop-default.xml /kube2hadoop/conf/kube2hadoop.xml
COPY --from=builder /apps/token-fetcher/build/libs/token-fetcher-*-all.jar /kube2hadoop/token-fetcher.jar

RUN chmod +x /hadoop2kube.sh

CMD [ "/hadoop2kube.sh" ]