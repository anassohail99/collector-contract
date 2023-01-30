// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "openzeppelin-contracts/contracts/security/ReentrancyGuard.sol";

contract Collector is Ownable, ReentrancyGuard {
    address public tokenAddress;
    uint256 public tokenBalance;
    mapping(address => uint256) internal userTokenBalances;

    event Collect(address indexed user, uint256 amount);

    constructor(address _tokenAddress) {
        tokenAddress = _tokenAddress;
    }

    function collect(uint256 amount) public {
        require(
            IERC20(tokenAddress).allowance(msg.sender, address(this)) >= amount,
            "NA"
        );
        IERC20(tokenAddress).transferFrom(msg.sender, owner(), amount);
        tokenBalance += amount;
        userTokenBalances[msg.sender] += amount;
        emit Collect(msg.sender, amount);
    }

    function userBalance(address tokenHolder) public view returns (uint256) {
        return userTokenBalances[tokenHolder];
    }
}
