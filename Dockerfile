FROM adoptopenjdk/openjdk8-openj9:jre

ENV AGENT=agent
ENV JAVA_OPTS "-Xshareclasses:cacheDir=/tmp/shareclasses -Xscmx2G -Xquickstart"

ADD https://www.apache.org/dist/flume/1.9.0/apache-flume-1.9.0-bin.tar.gz /tmp/apache-flume-1.9.0-bin.tar.gz

WORKDIR /tmp
RUN tar -xzf apache-flume-1.9.0-bin.tar.gz
RUN rm -rf /tmp/apache-flume-1.9.0-bin.tar.gz
RUN mv apache-flume-1.9.0-bin /apache-flume/
RUN cp /apache-flume/conf/flume-conf.properties.template /apache-flume/conf/flume-conf.properties

WORKDIR /apache-flume

CMD [ "sh","-c", "./bin/flume-ng agent -n ${AGENT} -c conf -f conf/flume-conf.properties" ]