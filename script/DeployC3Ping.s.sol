// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.27;

import { C3Ping } from "../src/C3Ping.sol";
import { Script, console } from "forge-std/Script.sol";

contract DeployC3Ping is Script {
    address c3caller;
    uint256 dappID;
    address mpc1;
    address mpc2;

    function run() public {
        try vm.envAddress("C3CALLER") returns (address _c3caller) {
            c3caller = _c3caller;
        } catch {
            revert("C3CALLER not defined");
        }

        try vm.envUint("DAPP_ID") returns (uint256 _dappID) {
            dappID = _dappID;
        } catch {
            revert("DAPP_ID not defined");
        }

        try vm.envAddress("MPC1") returns (address _mpc1) {
            mpc1 = _mpc1;
        } catch {
            revert("MPC1 not defined");
        }

        try vm.envAddress("MPC2") returns (address _mpc2) {
            mpc2 = _mpc2;
        } catch {
            revert("MPC2 not defined");
        }

        vm.startBroadcast();
        C3Ping c3ping = new C3Ping(c3caller, mpc1, dappID);
        c3ping.addTxSender(mpc2);
        vm.stopBroadcast();
    }
}