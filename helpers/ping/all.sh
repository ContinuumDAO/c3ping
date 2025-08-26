#!/bin/bash

# Check if required arguments are provided
if [ $# -lt 2 ]; then
    echo "Error: Missing required arguments."
    echo "Usage: $0 <ACCOUNT> <PASSWORD_FILE>"
    echo "Example: $0 0x1234... /path/to/password.txt"
    exit 1
fi

./helpers/ping/arbitrum-sepolia.sh $1 $2
./helpers/ping/bsc-testnet.sh $1 $2
./helpers/ping/sepolia.sh $1 $2
./helpers/ping/base-sepolia.sh $1 $2
./helpers/ping/scroll-sepolia.sh $1 $2
./helpers/ping/avalanche-fuji.sh $1 $2
./helpers/ping/holesky.sh $1 $2
./helpers/ping/opbnb-testnet.sh $1 $2
./helpers/ping/soneium-minato-testnet.sh $1 $2