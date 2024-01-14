{ repoRoot, inputs, pkgs, lib, system }:

let
  sha256map = {
    "https://github.com/input-output-hk/cardano-node-emulator". "3a43d5cfea9a5f01ec68e5d1aeea7429394d1191" =
      "sha256-3reCwN9mWAJZoep8qEzCcHw3JcgLyLd2XW3JUIIfnhQ=";
  };



  modules = [
    ({ config, ... }: {
      packages = {
        assignment.preCheck = "
        export CARDANO_CLI=${inputs.cardano-node.legacyPackages.cardano-cli}/bin/cardano-cli${pkgs.stdenv.hostPlatform.extensions.executable}
        export CARDANO_NODE=${inputs.cardano-node.legacyPackages.cardano-node}/bin/cardano-node${pkgs.stdenv.hostPlatform.extensions.executable}
        export CARDANO_SUBMIT_API=${inputs.cardano-node.legacyPackages.cardano-submit-api}/bin/cardano-submit-api${pkgs.stdenv.hostPlatform.extensions.executable}
        export CARDANO_NODE_SRC=${../.}
      ";

        assignment.ghcOptions = [ "-Werror" ];
      };
    })
  ];


  cabalProject = pkgs.haskell-nix.cabalProject' {
    inherit modules sha256map;
    src = ../.;
    name = "ppbl1013-assignment";
    compiler-nix-name = "ghc928";
    inputMap = { "https://input-output-hk.github.io/cardano-haskell-packages" = inputs.CHaP; };
    shell.withHoogle = false;
  };


  project = lib.iogx.mkHaskellProject {
    inherit cabalProject;
    shellArgs = repoRoot.nix.shell;
  };

in

project
