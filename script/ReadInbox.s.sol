// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.27;

import { Script } from "forge-std/Script.sol";
import { console } from "forge-std/console.sol";
import { IC3Ping } from "../src/flat/C3Ping.sol";
import { Utils } from "./Utils.s.sol";

contract ReadInbox is Script {
    address c3ping;
    address admin;

    mapping (uint256 => string) chainIdToName;

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

        chainIdToName[421614] = "Arbitrum Sepolia";
        chainIdToName[97] = "BSC Testnet";
        chainIdToName[11155111] = "Sepolia";
        chainIdToName[84532] = "Base Sepolia";
        chainIdToName[534351] = "Scroll Sepolia";
        chainIdToName[43113] = "Avalanche Fuji";
        chainIdToName[17000] = "Holesky";
        chainIdToName[5611] = "OPBNB Testnet";
        chainIdToName[1946] = "Soneium Minato Testnet";

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
                if (sender == address(0)) {
                    console.log("No message received from", chainIdToName[peerId], "to", chainIdToName[block.chainid]);
                    continue;
                } else {
                    console.log("Message : ", message);
                    console.log("Sender : ", sender);
                    console.log("Source Chain : ", chainIdToName[srcChainID]);
                    console.log("Destination Chain : ", chainIdToName[block.chainid]);
                    console.log("Date/Time : ", utils.timestampToDateString(timestamp));
                }
            }
        }
        console.log("\n--------------------------------\n");
    }
}