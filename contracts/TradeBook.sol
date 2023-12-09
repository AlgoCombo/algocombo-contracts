// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract TradeBook is Ownable {
    struct Trade {
        string id;
        address user;
        uint256 amount;
        address token0;
        address token1;
    }

    mapping(address => Trade[]) public trades;

    constructor() Ownable(msg.sender) {}

    function addTrade(address _user, Trade memory _trade) public onlyOwner {
        trades[_user].push(_trade);
    }

    function getTrades(address _user) public view returns (Trade[] memory) {
        Trade[] memory _trades = new Trade[](trades[_user].length);

        for (uint256 i = 0; i < trades[_user].length; ) {
            _trades[i] = trades[_user][i];
            unchecked {
                i++;
            }
        }

        return _trades;
    }
}
