# Local Kafka

Run a Kafka service locally without containers.

## Requirements

Install the [Nix package manager](https://nixos.org/download.html#download-nix).

## Usage

Run Zookeeper and Kafka:

```
nix run 'git+ssh://git@bitbucket.intra.nexthink.com:7999/~dawagner/local-kafka.git'
```

If you cloned the repo you can also start everything from the local repo:

```
nix run
```

Then, use the official Kafka tools:

```
kafka-topics.sh --bootstrap-server localhost:9092 --list
```
