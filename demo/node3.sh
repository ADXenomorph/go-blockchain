#!/bin/bash
export NODE_ID=5000

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $DIR/wallet.sh;

WALLET=$(createWallet);

while [ ! -f tmp/blocks_3000/SERVER_LOCK ]; do
    echo -n -e "\rWaiting for main node to start"
    sleep 0.5
done

echo "Starting miner node"
echo "go run main.go startnode -miner $WALLET"
go run main.go startnode -miner $WALLET