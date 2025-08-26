// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity 0.8.27;

import { Script } from "forge-std/Script.sol";
import { IC3Ping } from "../src/IC3Ping.sol";

contract Utils is Script {
    address c3ping;

    function getChainlist() public pure returns (uint256[] memory) {
        uint256[] memory chainlist = new uint256[](9);
        chainlist[0] = 421614;
        chainlist[1] = 97;
        chainlist[2] = 11155111;
        chainlist[3] = 17000;
        chainlist[4] = 43113;
        chainlist[5] = 534351;
        chainlist[6] = 1946;
        chainlist[7] = 84532;
        chainlist[8] = 5611;
        return chainlist;
    }
}