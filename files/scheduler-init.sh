#!/usr/bin/env bash

export LD_LIBRARY_PATH=$MESOS_SANDBOX/libmesos-bundle/lib:$LD_LIBRARY_PATH
export MESOS_NATIVE_JAVA_LIBRARY=$(ls $MESOS_SANDBOX/libmesos-bundle/lib/libmesos-*.so)
export JAVA_HOME=$(ls -d $MESOS_SANDBOX/jdk*/jre/)
export JAVA_HOME=${JAVA_HOME%/}
export PATH=$(ls -d $JAVA_HOME/bin):$PATH
export JAVA_OPTS=\"-Xms256M -Xmx512M -XX:-HeapDumpOnOutOfMemoryError\"

[ ! -z ${CONFIG_MUSTACHE_BASE64} ] && \
  rm -f ${MESOS_SANDBOX}/config.json.mustache && \
  echo "${CONFIG_MUSTACHE_BASE64}" | base64 -d > ${MESOS_SANDBOX}/config.json.mustache

./bootstrap -resolve=false -template=false 

./operator-scheduler/bin/operator svc.yml