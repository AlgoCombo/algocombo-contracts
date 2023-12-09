// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "uniswap-v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SushiSwapper {
    address private sushiRouterAddress;
    IUniswapV2Router02 private sushiRouter;

    constructor(address _sushiRouterAddress) {
        sushiRouterAddress = _sushiRouterAddress;
        sushiRouter = IUniswapV2Router02(_sushiRouterAddress);
    }

    function swapTokens(
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        uint256 amountOutMin
    ) external {
        // Transfer User's tokens to this contract
        IERC20(tokenIn).transferFrom(msg.sender, address(this), amountIn);

        // Approve SushiSwap router to spend the input token
        IERC20(tokenIn).approve(sushiRouterAddress, amountIn);

        // Define the path for the swap
        address[] memory path = new address[](2);
        path[0] = tokenIn;
        path[1] = tokenOut;

        // Perform the swap
        sushiRouter.swapExactTokensForTokens(
            amountIn,
            amountOutMin,
            path,
            msg.sender, // Txn Sender as the recipient of the swapped tokens
            block.timestamp + 1800 // 30 minutes deadline for the transaction
        );
    }
}
