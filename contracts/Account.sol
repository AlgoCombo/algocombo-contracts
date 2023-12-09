// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/interfaces/IERC20.sol";

contract Account {
    address public owner;
    address public factory;

    uint256 public tokenBalances;

    // To store the ERC20 tokens deposited in this lifetime
    address[] public tokenAddresses;
    mapping(address => bool) private tokenAddressExists;

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
        require(_amount > 0, "No ERC20 tokens sent");

        if (tokenAddressExists[_tokenAddress] == false) {
            tokenAddresses.push(_tokenAddress);
            tokenAddressExists[_tokenAddress] = true;
        }

        IERC20(_tokenAddress).transfer(address(this), _amount);
    }

    // Withdraw Functions
    function withdraw(uint256 _amount) public onlyOwner {
        require(address(this).balance >= _amount, "Insufficient Balance");
        payable(msg.sender).transfer(_amount);
    }

    function withdrawTokens(
        address _tokenAddress,
        uint256 _amount
    ) public onlyOwner {
        require(
            getTokenBalance(_tokenAddress) >= _amount,
            "Insufficient Balance"
        );
        IERC20(_tokenAddress).transfer(msg.sender, _amount);
    }

    // View Functions
    function getTokenBalance(
        address _tokenAddress
    ) private view returns (uint256) {
        return IERC20(_tokenAddress).balanceOf(address(this));
    }

    // Utility Functions
    function approve(address _tokenAddress) public onlyOwner {
        IERC20(_tokenAddress).approve(address(this), type(uint256).max);
    }
}
