// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.27;

import { IC3GovernDApp } from "@c3caller/gov/IC3GovernDApp.sol";
import { Script, console } from "forge-std/Script.sol";

contract AddMPC is Script {
    address newMPC;
    address c3ping;

    function run() public {
        try vm.envAddress("NEW_MPC") returns (address _newMPC) {
            newMPC = _newMPC;
        } catch {
            revert("NEW_MPC not defined");
        }

        try vm.envAddress("C3_PING") returns (address _c3ping) {
            c3ping = _c3ping;
        } catch {
            revert("C3_PING not defined");
        }

        vm.startBroadcast();

        IC3GovernDApp(c3ping).addTxSender(newMPC);
        console.log("New MPC address ", newMPC, " added on chain ID ", block.chainid);

        vm.stopBroadcast();
    }
}
