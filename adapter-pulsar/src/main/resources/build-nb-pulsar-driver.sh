#!/usr/local/bin/bash
(
  cd "$(git rev-parse --show-toplevel)" && \
    mvn clean install -DskipTests -pl adapters-api,adapter-pulsar,nb5
)
