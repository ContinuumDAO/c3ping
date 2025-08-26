#!/bin/bash

# Get the deployer address from the first argument
DEPLOYER=$1
PASSWORD_FILE=$2

# Check if the deployer address is provided
if [ -z "$DEPLOYER" ]; then
    echo "Error: Deployer address is required"
    echo "Usage: $0 <deployer_address> <path_to_password_file>"
    exit 1
fi

# Check if the password file is provided
if [ -z "$PASSWORD_FILE" ]; then
    echo "Error: Password file is required"
    echo "Usage: $0 <deployer_address> <path_to_password_file>"
    exit 1
fi

./helpers/check-nonce/arbitrum-sepolia.sh $DEPLOYER $PASSWORD_FILE
./helpers/check-nonce/bsc-testnet.sh $DEPLOYER $PASSWORD_FILE
./helpers/check-nonce/sepolia.sh $DEPLOYER $PASSWORD_FILE
./helpers/check-nonce/avalanche-fuji.sh $DEPLOYER $PASSWORD_FILE
./helpers/check-nonce/base-sepolia.sh $DEPLOYER $PASSWORD_FILE
./helpers/check-nonce/holesky.sh $DEPLOYER $PASSWORD_FILE
./helpers/check-nonce/opbnb-testnet.sh $DEPLOYER $PASSWORD_FILE
./helpers/check-nonce/scroll-sepolia.sh $DEPLOYER $PASSWORD_FILE
./helpers/check-nonce/soneium-minato-testnet.sh $DEPLOYER $PASSWORD_FILE