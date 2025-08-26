# Cross-Chain Communication Benchmark Results

This document contains the results of cross-chain message passing tests between Arbitrum Sepolia (chain ID 421614), BSC Testnet (chain ID 97), and Sepolia (chain ID 11155111).

## Test Results Table

| Source Chain Name    | Source Chain ID | Destination Chain Name | Destination Chain ID | Timestamp Sent | Timestamp Received | Delta (seconds) | Delta (mm:ss) |
|---------------------|----------------|-----------------------|---------------------|----------------|-------------------|-----------------|---------------|
| Arbitrum Sepolia    | 421614         | BSC Testnet           | 97                  | 1756058283     | 1756058321        | 38              | 0:38          |
| BSC Testnet         | 97             | Arbitrum Sepolia      | 421614              | 1756058431     | 1756058530        | 99              | 1:39          |
| Arbitrum Sepolia    | 421614         | Sepolia               | 11155111            | 1756058286     | 1756058328        | 42              | 0:42          |
| Sepolia             | 11155111       | Arbitrum Sepolia      | 421614              | 1756058604     | 1756059641        | 1037            | 17:17         |
| BSC Testnet         | 97             | Sepolia               | 11155111            | 1756058431     | 1756058544        | 113             | 1:53          |
| Sepolia             | 11155111       | BSC Testnet           | 97                  | 1756058604     | 1756059641        | 1037            | 17:17         |

## Analysis Summary

### Cross-Chain Communication Times

- **Arbitrum Sepolia ↔ BSC Testnet**: 
  - 421614 → 97: **38 seconds**
  - 97 → 421614: **99 seconds** (1 minute 39 seconds)

- **Arbitrum Sepolia ↔ Sepolia**: 
  - 421614 → 11155111: **42 seconds**
  - 11155111 → 421614: **1037 seconds** (17 minutes 17 seconds)

- **BSC Testnet ↔ Sepolia**: 
  - 97 → 11155111: **113 seconds** (1 minute 53 seconds)
  - 11155111 → 97: **1037 seconds** (17 minutes 17 seconds)

### Key Observations

1. **Directional Performance**: Communication from Sepolia to other networks takes significantly longer (over 17 minutes) compared to the reverse direction, which completes in under 2 minutes.

2. **Fastest Route**: Arbitrum Sepolia to BSC Testnet is the fastest at 38 seconds.

3. **Slowest Route**: Sepolia to both Arbitrum Sepolia and BSC Testnet takes over 17 minutes, indicating potential network congestion or processing delays on the Sepolia side.

4. **Consistent Performance**: Outbound communication from Arbitrum Sepolia and BSC Testnet shows consistent performance in the 1-2 minute range.

## Test Methodology

The data was collected by:
- Sending messages from each network to the other two networks
- Recording timestamps when messages were sent (outbox) and received (inbox)
- Calculating the time delta between send and receive events
- Converting timestamps to Unix epoch format for analysis

## Network Information

- **Arbitrum Sepolia**: Chain ID 421614
- **BSC Testnet**: Chain ID 97  
- **Sepolia**: Chain ID 11155111
