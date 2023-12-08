// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "./User.sol";

contract UserFactory {

    mapping(address => User) public userContract;

    function createUser() public returns (User) {
        User _user = new User(msg.sender, address(this));
        userContract[msg.sender] = _user;

        return _user;
    }
}
