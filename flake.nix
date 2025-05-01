{
  description = "Kafka and Zookeeper";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem
    (system:
      let

        pkgs = nixpkgs.legacyPackages.${system};

        broker-1 = pkgs.writeShellScriptBin "launch-zookeeper-and-broker" ''
          set -e
          # Start Zookeeper
          trap "${pkgs.zookeeper}/bin/zkServer.sh --config ${self} stop" EXIT
          ZOO_LOG_DIR=$(pwd) ${pkgs.zookeeper}/bin/zkServer.sh --config ${self} start

          # Start Kafka
          ${pkgs.apacheKafka}/bin/kafka-server-start.sh ${./broker-1.properties}
        '';

        broker-2 = pkgs.writeShellScriptBin "launch-broker" ''
          ${pkgs.apacheKafka}/bin/kafka-server-start.sh ${./broker-2.properties}
        '';

        broker-3 = pkgs.writeShellScriptBin "launch-broker" ''
          ${pkgs.apacheKafka}/bin/kafka-server-start.sh ${./broker-3.properties}
        '';

      in

      {
        devShells.default = with pkgs; mkShell {
          buildInputs = [
            apacheKafka
          ];
        };

        apps.default = self.apps.${system}.broker-1;

        apps.broker-1 = with pkgs; {
          type = "app";
          program = "${broker-1}/bin/launch-zookeeper-and-broker";
        };

        apps.broker-2 = with pkgs; {
          type = "app";
          program = "${broker-2}/bin/launch-broker";
        };

        apps.broker-3 = with pkgs; {
          type = "app";
          program = "${broker-3}/bin/launch-broker";
        };
      });
}
