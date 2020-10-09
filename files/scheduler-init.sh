#!/usr/bin/env bash

[ ! -z ${CONFIG_MUSTACHE_BASE64} ] && \
  rm -f ${MESOS_SANDBOX}/config.env.mustache && \
  echo "${CONFIG_MUSTACHE_BASE64}" | base64 -d > ${MESOS_SANDBOX}/config.env.mustache
