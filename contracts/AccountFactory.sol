// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "./Account.sol";

contract AccountFactory {

    mapping(address => Account[]) public accountContract;

    function createAccount() public returns (Account) {
        require(accountContract[msg.sender].length == 0, "User's Contract already exists");
        Account _account = new Account(msg.sender, address(this));
        accountContract[msg.sender].push(_account);

        return _account;
    }

    function getAccount(address _accountAddress) public view returns (Account) {
        return accountContract[_accountAddress][0];
    }
}
