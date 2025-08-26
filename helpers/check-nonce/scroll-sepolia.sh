#!/bin/bash

# Check if required arguments are provided
if [ $# -lt 2 ]; then
    echo "Error: Missing required arguments."
    echo "Usage: $0 <ACCOUNT> <PASSWORD_FILE>"
    echo "Example: $0 0x1234... /path/to/password.txt"
    exit 1
fi

echo -e "Nonce for scroll-sepolia (534351):"
cast nonce $(cast wallet address --account $1 --password-file $2) --rpc-url scroll-sepolia-rpc-url