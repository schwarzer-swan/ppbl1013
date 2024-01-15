# ppbl1013
A haskell nix flake project to for cardano plutus contract related development

## what is this
The nix/flake bootstrap a development environment to author plutus contracts. It also provides access to the release version of
- binaries to execute:
   * cardano-node
   * cardano-cli
   * cardano-submit-api


## what is for
plutus contract development and testing

## How to use it
- clone the repo

``` sh
nix develop
cabal update
cabal build assignment
cabal repl assignment
```
to run the cardano-node: 

``` sh
nohup ./startNode.sh "$(date +%s)" preprod 2>&1 > ~/dev/var/cardano-node.log &
tail -f  ~/dev/var/cardano-node.log &
```

## Assumptions
- nixos is installed with flake support
- cardano cache is enabled
- my OS is nixOS and I've also tried this on ubuntu

