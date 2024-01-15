#!/usr/bin/env sh
##
## Des: Start a cardano-node in the given env
## Usage: run-number cardano-environment
## nohup ./startNode "$(date +%s)" preprod 2>&1 > ~/dev/var/cardano-node.log &
##

if [ $# -lt 2 ]
then
        echo "Usage : $0 <run-number> :: 1|2|...|n <cardano-environment> :: mainnet | preprod | preview"
        exit
fi

RUN_NO="$1"
DIR="$HOME/dev/var/iohk/$RUN_NO/cardano-node"

PREPROD_DIR="$DIR/preprod"
URL_PREPROD='https://book.world.dev.cardano.org/environments/preprod'

MAINNET_DIR="$DIR/mainnet"
URL_MAINNET='https://book.world.dev.cardano.org/environments/mainnet'

PREVIEW_DIR="$DIR/preview"
URL_PREVIEW='https://book.world.dev.cardano.org/environments/preview'

case "$2" in
   preprod)
       URL=$URL_PREPROD
       CONFIG_DIR=$PREPROD_DIR
       ;;
   mainnet)
       URL=$URL_MAINNET
       CONFIG_DIR=$MAINNET_DIR
       ;;
   preview)
       URL=$URL_PREVIEW
       CONFIG_DIR=$PREVIEW_DIR
       ;;
   *) echo "$2 is not a valid environment"
      exit -1
esac

echo "Using CONFIG_DIR: $CONFIG_DIR"
echo "Using book.world.dev URL of: $URL"

mkdir -p "$CONFIG_DIR"
echo "$CONFIG_DIR"

pushd "$CONFIG_DIR"

for i in \
   conway-genesis.json \
   config.json \
   db-sync-config.json \
   submit-api-config.json \
   topology.json \
   byron-genesis.json \
   shelley-genesis.json \
   alonzo-genesis.json
do
     rm -f ./$i ## only remove what we download
     wget "$URL/$i"
done
pwd && ls -la
echo "==== completed downloading configs ==="
popd

export CARDANO_NODE_SOCKET_PATH="$CONFIG_DIR/cardano-node.socket"

echo "+++++++++++++++++++++++"
echo "using cardano-node version: $(cardano-node --version)"
echo "using cardano-cli version: $(cardano-cli --version)"
echo -n "using socket path:"
echo $CARDANO_NODE_SOCKET_PATH
echo "+++++++++++++++++++++++"

cardano-node run \
  --config "$CONFIG_DIR/config.json" \
  --topology "$CONFIG_DIR/topology.json" \
  --database-path "$CONFIG_DIR/.db2" \
  --socket-path "$CARDANO_NODE_SOCKET_PATH"
