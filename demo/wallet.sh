#!/bin/bash

function createWallet {
    echo "Creating wallet" > /dev/tty
    echo "go run main.go createwallet" > /dev/tty
    local newWallet=$(go run main.go createwallet | sed 's/.*\(.\{34\}\)/\1/')
    echo "Created wallet $newWallet" > /dev/tty
    echo "" > /dev/tty

    echo $newWallet > "tmp/demo/wallet$NODE_ID"

    echo "$newWallet"
}

function getWallet {
    walletId=$1
    local foundWallet=""
    while [ ! -f "tmp/demo/wallet$walletId" ]; do
        echo -n -e "\rWaiting for wallet $walletId" > /dev/tty
        sleep 0.5
    done
    while [ -z "$foundWallet" ]; do
        echo -n -e "\rWaiting for wallet $walletId" > /dev/tty
        foundWallet=`cat tmp/demo/wallet$walletId`
        sleep 0.5
    done
    echo "" > /dev/tty
    echo "Wallet $walletId is $foundWallet" > /dev/tty
    echo "" > /dev/tty

    echo "$foundWallet"
}
