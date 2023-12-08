// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/interfaces/IERC20.sol";

contract Account {
    address public owner;
    address public factory;

    uint256 public tokenBalances;

    // modifier onlyAdmin {
    //     require(msg.sender == owner || msg.sender == factory, "Only Admin Allowed");
    //     _;
    // }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only Owner Allowed");
        _;
    }

    constructor(address _owner, address _factory) {
        owner = _owner;
        factory = _factory;
    }

    // Deposit Functions
    function deposit() public payable onlyOwner {
        require(msg.value > 0, "No native tokens sent");
    }

    function depositTokens(
        address _tokenAddress,
        uint256 _amount
    ) public onlyOwner {
        IERC20(_tokenAddress).transfer(address(this), _amount);
    }

    // Withdraw Functions
    function withdraw(uint256 _amount) public onlyOwner {
        require(address(this).balance >= _amount, "Insufficient Balance");
        payable(owner).transfer(_amount);
    }

    function withdrawTokens(
        address _tokenAddress,
        uint256 _amount
    ) public onlyOwner {
        require(tokenBalance(_tokenAddress) >= _amount, "Insufficient Balance");
        IERC20(_tokenAddress).transfer(owner, _amount);
    }

    // View Functions
    function tokenBalance(
        address _tokenAddress
    ) private view returns (uint256) {
        return IERC20(_tokenAddress).balanceOf(address(this));
    }

    // Utility Functions
    function approve(address _tokenAddress) public onlyOwner {
        IERC20(_tokenAddress).approve(address(this), type(uint256).max);
    }
}
