FROM tomcat:jdk11-corretto

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.description="UniTime is a comprehensive educational scheduling system." \
      org.label-schema.name="kugland/unitime" \
      org.label-schema.url="https://hub.docker.com/r/kugland/unitime" \
      org.label-schema.vcs-url="https://github.com/kugland/docker-unitime"

ENV UNITIME_PKG="https://github.com/UniTime/unitime/releases/download/v4.6.82/unitime-4.6_bld82.zip"
ENV UNITIME_SHA256SUM="2610f03337b3389e6a0d43cb8bc3cdb48f6e8db7d1ee0557a1927de60b5ef89b"
ENV MYSQL_CONNECTOR_PKG="https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.29.zip"
ENV MYSQL_CONNECTOR_SHA256SUM="a82a2d5a7c31f74ada0b7952ae249730837e35adfaec966a3cfab5e2f545fdcf"

RUN { \
  set -eux -o pipefail; \
  curl -sfL -o /tmp/unitime.zip "${UNITIME_PKG}" ; \
  sha256sum /tmp/unitime.zip | grep "^${UNITIME_SHA256SUM}[[:blank:]]" ; \
  curl -sfL -o /tmp/mysql-connector.zip "${MYSQL_CONNECTOR_PKG}" ; \
  sha256sum /tmp/mysql-connector.zip | grep "^${MYSQL_CONNECTOR_SHA256SUM}[[:blank:]]" ; \
  yum install -y unzip ; \
  unzip -j -d /tmp /tmp/unitime.zip web/UniTime.war ; \
  mkdir -p "${CATALINA_HOME}/webapps/UniTime" ; \
  unzip -d "${CATALINA_HOME}/webapps/UniTime" /tmp/UniTime.war ; \
  unzip -j -d "${CATALINA_HOME}/lib/" /tmp/mysql-connector.zip '*/mysql-connector-java-*.jar' ; \
  rm /tmp/unitime.zip /tmp/UniTime.war /tmp/mysql-connector.zip ; \
  yum erase -y unzip && yum clean all && rm -rf /var/cache/yum/ ; \
}

ENV JAVA_OPTS="-Xmx2048m -Djava.awt.headless=true -Dtmtbl.custom.properties=/etc/default/unitime.properties"

VOLUME /etc/default/unitime.properties
