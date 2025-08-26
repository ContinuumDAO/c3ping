// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.27;

struct SendReceipt {
    string message;
    address recipient;
    uint256 dstChainID;
    uint48 timestamp;
}

struct ReceiveReceipt {
    string message;
    address sender;
    uint256 srcChainID;
    uint48 timestamp;
}

interface IC3Ping {
    event MessageSent(
        string message, address sender, address recipient, uint256 srcChainID, uint256 dstChainID, uint48 timestamp
    );
    event MessageReceived(
        string message, address sender, address recipient, uint256 srcChainID, uint256 dstChainID, uint48 timestamp
    );
    event C3Error(bytes data);

    error MessageEmpty();
    error InvalidChainID(uint256);

    function sendMessage(address recipient, string memory message, uint256 dstChainID) external;
    function receiveMessage(address sender, address recipient, string memory message) external returns (bool);
    function setChainIDValidation(uint256 chainID, bool isValid) external;
    function validChainID(uint256 chainID) external view returns (bool);
    function outbox(address recipient, uint256 chainID)
        external
        view
        returns (string memory message, address sender, uint256 srcChainID, uint48 timestamp);
    function inbox(address recipient, uint256 chainID)
        external
        view
        returns (string memory message, address sender, uint256 dstChainID, uint48 timestamp);
}
