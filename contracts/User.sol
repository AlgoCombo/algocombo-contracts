// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract User {

    address public owner;
    address public factory;

    modifier onlyAdmin {
        require(msg.sender == owner || msg.sender == factory, "Only Admin Allowed");
        _;
    }

    constructor(address _owner, address _factory){
        owner = _owner;
        factory = _factory;
    }
}
