#!/bin/bash

CONF_FILE=/kube2hadoop/conf/kube2hadoop.xml
CONF_PATH=$(dirname $CONF_FILE)
JAVA_HOME=${JAVA_HOME:-jdk/JDK-1_8_0_172}
JAR_PATH=/kube2hadoop/token-fetcher.jar

[ ! -f $CONF_FILE ] && echo "ERROR: Unable to find '$CONF_FILE'" && exit 2

{{- if .Values.conf.caFreeIPA }}
keytool --import --storepass changeit --noprompt --keystore /etc/ssl/certs/java/cacerts --file /kube2hadoop/conf/ca-freeipa.pem
{{- end }}

echo "$(date +'%F %T') Starting kube2hadoop..."
exec java {{ if .Values.conf.krb5ConfFile }}-Djava.security.krb5.conf=/kube2hadoop/conf/krb5.conf{{- end }} -cp "$JAR_PATH:$CONF_PATH" com.linkedin.kube2hadoop.TokenServer -conf_file $CONF_FILE