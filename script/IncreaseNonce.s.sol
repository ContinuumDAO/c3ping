// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.27;

import { Script } from "forge-std/Script.sol";
import { console } from "forge-std/console.sol";

contract IncreaseNonce is Script {
    uint256 public constant GAS_LIMIT = 21_000;

    // Default entry point for Foundry scripts (no parameters)
    function run() public {
        run(vm.envAddress("DEPLOYER_ADDRESS"), 1);
    }

    function run(address _deployer, uint256 _count) public {
        console.log("Deployer address:", _deployer);
        console.log("Current nonce:", vm.getNonce(_deployer));
        console.log("Increasing nonce by", _count, "transactions...");

        vm.startBroadcast();

        // Send empty transactions to increase nonce
        for (uint256 i = 0; i < _count; i++) {
            // Send transaction to self (empty transaction)
            (bool success,) = _deployer.call{ value: 0, gas: GAS_LIMIT }("");
            require(success, "Transaction failed");

            console.log("Sent transaction", i + 1, "/", _count);
        }

        vm.stopBroadcast();

        console.log("Final nonce:", vm.getNonce(_deployer));
        console.log("Nonce increase completed successfully!");
    }
}
