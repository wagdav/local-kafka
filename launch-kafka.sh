#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

KAFKA=$(nix build nixpkgs#apacheKafka --no-link --json | jq -r '.[0].outputs.out')
ZOOKEEPER=$(nix build nixpkgs#zookeeper --no-link --json | jq -r '.[0].outputs.out')

# Start Zookeeper
trap "$ZOOKEEPER/bin/zkServer.sh --config $SCRIPT_DIR stop" SIGINT
ZOO_LOG_DIR=$SCRIPT_DIR $ZOOKEEPER/bin/zkServer.sh --config $SCRIPT_DIR start

# Start Kafka
$KAFKA/bin/kafka-server-start.sh $KAFKA/config/server.properties
