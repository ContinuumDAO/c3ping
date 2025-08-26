#!/bin/bash

# Check if required arguments are provided
if [ $# -lt 2 ]; then
    echo "Error: Missing required arguments."
    echo "Usage: $0 <ACCOUNT> <PASSWORD_FILE>"
    echo "Example: $0 0x1234... /path/to/password.txt"
    exit 1
fi

# Simulate the validation
forge script script/ValidateChainIDs.s.sol \
--account $1 \
--password-file $2 \
--rpc-url opbnb-testnet-rpc-url \
--chain opbnb-testnet

# Check if the simulation succeeded
if [ $? -ne 0 ]; then
    echo "Simulation failed. Exiting."
    exit 1
fi

read -p "Continue with validation? [Y/n] " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]] && [[ ! $REPLY =~ ^$ ]]; then
    echo "Validation cancelled."
    exit 1
fi

echo "Proceeding with validation..."

forge script script/ValidateChainIDs.s.sol \
--account $1 \
--password-file $2 \
--rpc-url opbnb-testnet-rpc-url \
--chain opbnb-testnet \
--broadcast

echo "Validation complete."