# Local Kafka

Run a Kafka service locally without containers.

## Requirements

Install the [Nix package manager](https://nixos.org/download.html#download-nix).

## Usage

## Run Zookeeper and a Kafka broker

```
nix run github:wagdav/local-kafka
```

Or, If you cloned the repo you can also start everything from the local repo:

```
nix run
```

Then, use the official Kafka tools, for example to list the topics:

```
nix develop --command kafka-topics.sh --bootstrap-server localhost:9092 --list
```

## Run a three-broker cluster

Run the following commands in three separate terminal windows
```
nix run github:wagdav/local-kafka           # ZooKeeper and broker-0
nix run github:wagdav/local-kafka#broker-1  # broker-1
nix run github:wagdav/local-kafka#broker-2  # broker-2
```
