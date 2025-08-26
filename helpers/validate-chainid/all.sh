#!/bin/bash

# Check if required arguments are provided
if [ $# -lt 2 ]; then
    echo "Error: Missing required arguments."
    echo "Usage: $0 <ACCOUNT> <PASSWORD_FILE>"
    echo "Example: $0 0x1234... /path/to/password.txt"
    exit 1
fi

./helpers/validate-chainid/arbitrum-sepolia.sh $1 $2
./helpers/validate-chainid/bsc-testnet.sh $1 $2
./helpers/validate-chainid/sepolia.sh $1 $2
./helpers/validate-chainid/base-sepolia.sh $1 $2
./helpers/validate-chainid/avalanche-fuji.sh $1 $2
./helpers/validate-chainid/scroll-sepolia.sh $1 $2
./helpers/validate-chainid/soneium-minato-testnet.sh $1 $2
./helpers/validate-chainid/holesky.sh $1 $2
./helpers/validate-chainid/opbnb-testnet.sh $1 $2