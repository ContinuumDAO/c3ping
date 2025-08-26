#!/bin/bash

if [ $# -lt 3 ]; then
    echo "Error: Missing required arguments."
    echo "Usage: $0 <ACCOUNT> <PASSWORD_FILE> <COUNT>"
    echo "Example: $0 0x1234... /path/to/password.txt 1"
    exit 1
fi

# ./helpers/increase-nonce/arbitrum-sepolia.sh $1 $2 $3
# ./helpers/increase-nonce/sepolia.sh $1 $2 $3
# ./helpers/increase-nonce/bsc-testnet.sh $1 $2 $3
./helpers/increase-nonce/avalanche-fuji.sh $1 $2 $3
./helpers/increase-nonce/base-sepolia.sh $1 $2 $3
./helpers/increase-nonce/holesky.sh $1 $2 $3
./helpers/increase-nonce/opbnb-testnet.sh $1 $2 $3
./helpers/increase-nonce/scroll-sepolia.sh $1 $2 $3
./helpers/increase-nonce/soneium-minato-testnet.sh $1 $2 $3