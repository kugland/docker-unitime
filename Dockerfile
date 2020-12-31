FROM tomcat:jdk11-corretto

ARG VCS_REF
ARG BUILD_DATE

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.description="UniTime is a comprehensive educational scheduling system." \
      org.label-schema.name="kugland/unitime" \
      org.label-schema.url="https://hub.docker.com/r/kugland/unitime" \
      org.label-schema.vcs-url="https://github.com/kugland/docker-unitime" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF

COPY ./install-unitime.sh /tmp/install-unitime.sh
RUN sh /tmp/install-unitime.sh

ENV JAVA_OPTS="-Xmx2048m -Djava.awt.headless=true -Dtmtbl.custom.properties=/etc/default/unitime.properties"

VOLUME /etc/default/unitime.properties
