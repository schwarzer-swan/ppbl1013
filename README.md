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
- invoke the nix develop
- build the project
- execute the project
- examine the text files in the output folder
``` sh
nix develop
rm -rf ./output
mkdir ./output
cabal update
cabal build all
$(cabal exec -- which assignment)
ll ./output/
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

