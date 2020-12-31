FROM tomcat:jdk11-corretto

ENV UNITIME_PKG="https://github.com/UniTime/unitime/releases/download/v4.5.124/unitime-4.5_bld124.zip" \
    UNITIME_MD5SUM="3f95cb2044ea744f4df3d8509a65d13a" \
    MYSQL_CONNECTOR_PKG="https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.22.zip" \
    MYSQL_CONNECTOR_MD5SUM="2aaf6a62a2f3330730ec77b1c025646f"

COPY ./install-unitime.sh /tmp/install-unitime.sh
RUN sh /tmp/install-unitime.sh

ENV JAVA_OPTS="-Xmx2048m -Djava.awt.headless=true -Dtmtbl.custom.properties=/etc/default/unitime.properties"

VOLUME /etc/default/unitime.properties
