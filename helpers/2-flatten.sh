#!/bin/bash

# remove old flattened files
rm -r src/flat/

# create folders
mkdir -p src/flat/

forge flatten src/C3Ping.sol --output src/flat/C3Ping.sol
