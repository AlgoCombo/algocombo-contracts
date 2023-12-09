// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract TradeBook as Ownable {

    struct Trade {
        id: string
        user: address
        amount: uint256
        token0: address
        token1: address
    }
    
    mapping(address => Trade[]) public trades;

    function addTrade(address _user, Trade _trade) public onlyOwner {
        trades[_user].push(_trade);
    }

    function getTrades(address _user) public returns (Trade) {
        return trades[_user];
    }

}
