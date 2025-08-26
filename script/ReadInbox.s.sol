// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.27;

import { Script } from "forge-std/Script.sol";
import { console } from "forge-std/console.sol";
import { IC3Ping } from "../src/flat/C3Ping.sol";
import { Utils } from "./Utils.s.sol";

contract ReadInbox is Script {
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

        for (uint8 i = 0; i < chainlist.length; i++) {
            uint256 peerId = chainlist[i];
            if (peerId == block.chainid) {
                continue;
            } else {
                (string memory message, address sender, uint256 srcChainID, uint48 timestamp) =
                    IC3Ping(c3ping).inbox(admin, peerId);
                console.log("\n--------------------------------\n");
                console.log("Message : ", message);
                console.log("Sender : ", sender);
                console.log("SrcChainID : ", srcChainID);
                console.log("DstChainID : ", block.chainid);
                console.log("Timestamp : ", timestamp);
            }
        }
        console.log("\n--------------------------------\n");
    }
}