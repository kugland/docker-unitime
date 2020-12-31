#!/bin/sh

set -e

echo "Downloading Unitime from '${UNITIME_PKG}' ..."
curl -sfL -o /tmp/unitime.zip "${UNITIME_PKG}"
md5sum /tmp/unitime.zip | grep "^${UNITIME_MD5SUM}\s" \
  && echo "Checksum matched for Unitime package" \
  || echo "Checksum failed for Unitime package"

echo "Downloading mysql-connector from '${MYSQL_CONNECTOR_PKG}' ..."
curl -sfL -o /tmp/mysql-connector.zip "${MYSQL_CONNECTOR_PKG}"
md5sum /tmp/mysql-connector.zip | grep "^${MYSQL_CONNECTOR_MD5SUM}\s" \
  && echo "Checksum matched for mysql-connector package" \
  || echo "Checksum failed for mysql-connector package"

yum install -y unzip

unzip -j -d /tmp /tmp/unitime.zip web/UniTime.war
mkdir -p "${CATALINA_HOME}/webapps/UniTime"
unzip -d "${CATALINA_HOME}/webapps/UniTime" /tmp/UniTime.war
rm /tmp/unitime.zip
rm /tmp/UniTime.war

unzip -j -d "${CATALINA_HOME}/lib/" /tmp/mysql-connector.zip '*/mysql-connector-java-*.jar'
rm /tmp/mysql-connector.zip

yum erase -y unzip && yum clean all && rm -rf /var/cache/yum/
