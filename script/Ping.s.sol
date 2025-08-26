// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.27;

import { IC3Ping } from "../src/flat/C3Ping.sol";
import { Script, console } from "forge-std/Script.sol";
import { Utils } from "./Utils.s.sol";

contract Ping is Script {
    address c3ping;
    address admin;

    function run() public {
        try vm.envAddress("C3_PING") returns (address _c3ping) {
            c3ping = _c3ping;
        } catch {
            revert("C3_PING not defined");
        }

        try vm.envAddress("ADMIN") returns (address _admin) {
            admin = _admin;
        } catch {
            revert("ADMIN not defined");
        }

        Utils utils = new Utils();
        uint256[] memory chainlist = utils.getChainlist();

        vm.startBroadcast();

        uint256 ts = block.timestamp;
        uint256 day = ts % 86_400;
        uint256 hour = day / 3600;
        uint256 minute = (day - (hour * 3600)) / 60;
        uint256 second = day - ((minute * 60) + (hour * 3600));

        console.log("HH: ", hour);
        console.log("MM: ", minute);
        console.log("SS: ", second);

        for (uint8 i = 0; i < chainlist.length; i++) {
            uint256 peerId = chainlist[i];
            if (peerId == block.chainid) {
                continue;
            } else {
                string memory message = string.concat("Ping from ", vm.toString(block.chainid), " to ", vm.toString(peerId));
                IC3Ping(c3ping).sendMessage(admin, message, peerId);
                console.log("Sent message to chain", peerId, ":", message);
            }
        }

        vm.stopBroadcast();
    }
}
