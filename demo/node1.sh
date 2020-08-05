#!/bin/bash
rm -rf tmp/*
mkdir -p tmp/demo;

export NODE_ID=3000

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $DIR/wallet.sh

WALLET=$(createWallet)

echo "Creating blockchain"
echo "go run main.go createblockchain -address $WALLET"
go run main.go createblockchain -address $WALLET
echo ""

echo "Copying blockchain to other nodes"
echo "cp -r tmp/blocks_3000 tmp/blocks_4000"
cp -r tmp/blocks_3000 tmp/blocks_4000
echo "cp -r tmp/blocks_3000 tmp/blocks_5000"
cp -r tmp/blocks_3000 tmp/blocks_5000
echo "cp -r tmp/blocks_3000 tmp/blocks_gen"
cp -r tmp/blocks_3000 tmp/blocks_gen
echo ""

WALLET4000=$(getWallet 4000)

echo "Sending 10 tokens to wallet 4000"
echo "go run main.go send -from $WALLET -to $WALLET4000 -amount 10 -mine"
go run main.go send -from $WALLET -to $WALLET4000 -amount 10 -mine
echo ""

echo "Starting node"
echo "go run main.go startnode"
go run main.go startnode

echo "Done"