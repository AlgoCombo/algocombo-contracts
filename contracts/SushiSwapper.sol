// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "uniswap-v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SushiSwapper {
    event SwapEvent(
        address indexed user,
        address indexed tokenIn,
        address indexed tokenOut,
        uint256 amountIn,
        uint256 amountOut
    );

    struct Swap {
        address user;
        address tokenIn;
        address tokenOut;
        uint256 amountIn;
        uint256 amountOut;
    }

    address private sushiRouterAddress;
    IUniswapV2Router02 private sushiRouter;

    mapping(address => Swap[]) private swaps;

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
        // Initial Balance of tokenOut of user
        uint256 initialBalance = IERC20(tokenOut).balanceOf(msg.sender);

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

        // Final Balance of tokenOut of user
        uint256 finalBalance = IERC20(tokenOut).balanceOf(msg.sender);

        uint256 amountOut = finalBalance - initialBalance;

        Swap memory _swap = Swap(
            msg.sender,
            tokenIn,
            tokenOut,
            amountIn,
            amountOut
        );

        swaps[msg.sender].push(_swap);

        emit SwapEvent(msg.sender, tokenIn, tokenOut, amountIn, amountOut);
    }

    function getSwaps(address _user) external view returns (Swap[] memory) {
        Swap[] memory _swaps = new Swap[](swaps[_user].length);

        for (uint256 i = 0; i < swaps[_user].length; ) {
            _swaps[i] = swaps[_user][i];
            unchecked {
                i++;
            }
        }

        return _swaps;
    }
}
