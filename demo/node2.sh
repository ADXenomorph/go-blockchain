#!/bin/bash
export NODE_ID=4000

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $DIR/wallet.sh;

WALLET=$(createWallet);

while [ ! -f tmp/blocks_3000/SERVER_LOCK ]; do
    echo -n -e "\rWaiting for main node to start"
    sleep 0.5
done

echo "Starting node"
echo "go run main.go startnode"
go run main.go startnode

WALLET5000=$(getWallet 5000)
WALLET3000=$(getWallet 3000)

echo "Sending tokens from 4000 to 3000"
echo "go run main.go send -from $WALLET -to $WALLET3000 -amount 1"
go run main.go send -from $WALLET -to $WALLET3000 -amount 5
echo ""

sleep 5

echo "Sending tokens from 4000 to 5000"
echo "go run main.go send -from $WALLET -to $WALLET5000 -amount 3"
go run main.go send -from $WALLET -to $WALLET5000 -amount 3
echo ""

sleep 10


echo "Starting node"
echo "go run main.go startnode"
go run main.go startnode
