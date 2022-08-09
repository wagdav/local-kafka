# Local Kafka

Run a Kafka service locally without containers.

## Requirements

Install the [Nix package manager](https://nixos.org/download.html#download-nix).

## Usage

Launch a Zookeeper and Kafka locally:

```
./launch-kafka.sh
```

Use the official Kafka tools:

```
kafka-topics.sh --bootstrap-server localhost:9092 --list
```
