{ repoRoot, inputs, pkgs, lib, system }:

_cabalProject:

let
  cardano-cli = inputs.cardano-node.legacyPackages.cardano-cli;
  cardano-node = inputs.cardano-node.legacyPackages.cardano-node;
  cardano-submit-api = inputs.cardano-node.legacyPackages.cardano-submit-api;
in
{
  name = "ppbl1013-assignment";
  packages = [
    cardano-cli
    cardano-node
    cardano-submit-api
    inputs.mithril.packages.mithril-client
    pkgs.ghcid
    pkgs.haskellPackages.hoogle
  ];

  env = {
    CARDANO_CLI = "${cardano-cli}/bin/cardano-cli";
    CARDANO_NODE = "${cardano-node}/bin/cardano-node";
    CARDANO_SUBMIT_API = "${cardano-submit-api}/bin/cardano-submit-api";
  };


  preCommit = {
    # NOTE: when this attribute set changes, `.pre-commit-config.yaml` (which is a sym link to the nix store) changes.
    #       To maintain a the same hooks for both nix and non-nix environment you should update the `.pre-commit-config.yaml.nonix`
    #       (`cp .pre-commit-config.yaml .pre-commit-config.yaml.nonix`).
    #       This step is necessary because `.pre-commit-config.yaml` is ignored by git.
    cabal-fmt.enable = true;
    stylish-haskell.enable = true;
    nixpkgs-fmt.enable = true;
  };
}
