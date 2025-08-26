// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.27;

import { IC3Ping, ReceiveReceipt, SendReceipt } from "./IC3Ping.sol";
import { IC3Caller } from "@c3caller/IC3Caller.sol";
import { C3GovernDApp } from "@c3caller/gov/C3GovernDApp.sol";
import { Strings } from "@openzeppelin/contracts/utils/Strings.sol";

contract C3Ping is C3GovernDApp, IC3Ping {
    using Strings for *;

    mapping(uint256 => bool) public validChainID;
    mapping(address => mapping(uint256 chainID => SendReceipt)) public outbox;
    mapping(address => mapping(uint256 chainID => ReceiveReceipt)) public inbox;

    constructor(address c3caller, address mpc, uint256 dappID) C3GovernDApp(msg.sender, c3caller, mpc, dappID) { }

    function sendMessage(address recipient, string memory message, uint256 dstChainID) external {
        if (bytes(message).length == 0) {
            revert MessageEmpty();
        }
        if (!validChainID[dstChainID]) {
            revert InvalidChainID(dstChainID);
        }

        bytes memory _data =
            abi.encodeWithSignature("receiveMessage(address,address,string)", msg.sender, recipient, message);
        _c3call(address(this).toHexString(), dstChainID.toString(), _data);

        outbox[msg.sender][dstChainID] = SendReceipt(message, recipient, dstChainID, uint48(block.timestamp));

        emit MessageSent(message, msg.sender, recipient, block.chainid, dstChainID, uint48(block.timestamp));
    }

    function receiveMessage(address sender, address recipient, string memory message)
        external
        onlyCaller
        returns (bool)
    {
        (, string memory srcChainIDStr,) = IC3Caller(c3CallerProxy).context();
        uint256 srcChainID = srcChainIDStr.parseUint();

        inbox[recipient][srcChainID] = ReceiveReceipt(message, sender, srcChainID, uint48(block.timestamp));

        emit MessageReceived(message, sender, recipient, srcChainID, block.chainid, uint48(block.timestamp));

        return true;
    }

    function setChainIDValidation(uint256 chainID, bool isValid) external onlyGov {
        validChainID[chainID] = isValid;
    }

    function _c3Fallback(bytes4 _selector, bytes calldata _data, bytes calldata _reason)
        internal
        override
        returns (bool)
    {
        emit C3Error(abi.encodePacked(_selector, _data, _reason));
        return true;
    }
}
