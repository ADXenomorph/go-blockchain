# go-blockchain
A test app to try out implementing blockchain currency using go

Based on tutorials from tensor:

https://steemit.com/@tensor/posts

https://github.com/tensor-programming

https://www.youtube.com/c/tensor-programming

# Demo

If you just want to see blockchain in action run
```
make demo
```
Demo tool uses `screen` and some other bash cli tools

# Usage

Run `go build` and then `./go-blockchain`

or just run `go run main.go`

It will output instructions on how to use the blockchain:
```
Usage:
 getbalance -address ADDRESS - get the balance for an address
 createblockchain -address ADDRESS creates a blockchain and sends genesis reward to address
 printchain - Prints the blocks in the chain
 send -from FROM -to TO -amount AMOUNT -mine - Send amount of coins. Then -mine flag is set, mine off of this node 
 createwallet - Creates a new Wallet
 listaddresses - Lists the addresses in our wallet file
 reindexutxo - Rebuilds the UTXO set
 startnode -miner ADDRESS - Start a node with ID specified in NODE_ID env. var. -miner enable mining
```

First you would want to intially create a wallet for a node:
```
NODE_ID=3000 go run main.go createwallet
```

Then you can initialize a blockchain using this wallet
```
NODE_ID=3000 go run main.go createblockchain -address YourWalletId
```

After that its ready to be used. 

You might want to run a miner node, that will mine new blocks:
```
NODE_ID=4000 go run main.go createwallet
NODE_ID=4000 go run main.go startnode -miner newWalletAddress
```

If you want to send tokens to another node:
```
NODE_ID=3000 go run main.go send -from YourWalletId -to DifferentWalletId -amount 1
```
Send and mine the same amount:
```
NODE_ID=3000 go run main.go send -from YourWalletId -to DifferentWalletId -amount 1 -mine
```

List balance of the wallet:
```
go run main.go getbalance -address YourWalletId
```