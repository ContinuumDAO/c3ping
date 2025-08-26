#!/bin/bash

# Check if required arguments are provided
if [ $# -lt 3 ]; then
    echo "Error: Missing required arguments."
    echo "Usage: $0 <ACCOUNT> <PASSWORD_FILE> <NONCE>"
    echo "Example: $0 0x1234... /path/to/password.txt 1"
    exit 1
fi

echo "Proceeding with nonce increase of $3 on Avalanche Fuji..."

forge script script/IncreaseNonce.s.sol \
--account $1 \
--password-file $2 \
--rpc-url avalanche-fuji-rpc-url \
--chain avalanche-fuji \
--broadcast \
--sig "run(address,uint256)" \
-- $(cast wallet address --account $1 --password-file $2) $3

echo "Nonce increase of $3 on Avalanche Fuji complete."
