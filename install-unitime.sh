#!/bin/sh

set -e

UNITIME_PKG="https://github.com/UniTime/unitime/releases/download/v4.5.124/unitime-4.5_bld124.zip"
UNITIME_MD5SUM="3f95cb2044ea744f4df3d8509a65d13a"
MYSQL_CONNECTOR_PKG="https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.22.zip"
MYSQL_CONNECTOR_MD5SUM="2aaf6a62a2f3330730ec77b1c025646f"

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

rm "$(realpath $0)" # Delete myself. :)
