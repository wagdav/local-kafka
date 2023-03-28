{
  description = "Kafka and Zookeeper";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem
  (system:
   let

    pkgs = nixpkgs.legacyPackages.${system};

    script = pkgs.writeShellScriptBin "launch-kafka" ''
        # Start Zookeeper
        trap "${pkgs.zookeeper}/bin/zkServer.sh --config ${self} stop" SIGINT
        ZOO_LOG_DIR=$(pwd) ${pkgs.zookeeper}/bin/zkServer.sh --config ${self} start

        # Start Kafka
        ${pkgs.apacheKafka}/bin/kafka-server-start.sh ${./server.properties}
    '';

   in

   {
     devShells.default = with pkgs; mkShell {
       buildInputs = [
         apacheKafka
       ];
     };

     apps.default = with pkgs; {
       type = "app";
       program = "${script}/bin/launch-kafka";
     };
   });
}
