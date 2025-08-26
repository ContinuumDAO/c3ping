// SPDX-License-Identifier: UNLICENSED

pragma solidity =0.8.27;

import { IC3Ping } from "../src/flat/C3Ping.sol";
import { Script, console } from "forge-std/Script.sol";
import { Utils } from "./Utils.s.sol";

contract ValidateChainIDs is Script {
    address c3ping;

    function run() public {
        try vm.envAddress("C3_PING") returns (address _c3ping) {
            c3ping = _c3ping;
        } catch {
            revert("C3_PING not defined");
        }

        Utils utils = new Utils();
        uint256[] memory chainlist = utils.getChainlist();

        vm.startBroadcast();
        for (uint256 i = 0; i < chainlist.length; i++) {
            if (chainlist[i] == block.chainid) {
                continue;
            } else {
                IC3Ping(c3ping).setChainIDValidation(chainlist[i], true);
            }
        }
        vm.stopBroadcast();
    }
}