// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";


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
            "STF"
        );
        IERC20(tokenAddress).transferFrom(msg.sender, address(this), amount);
        tokenBalance += amount;
        userTokenBalances[msg.sender] += amount;
        emit Collect(msg.sender,amount);
    }

    function userBalance(address tokenHolder) public view returns (uint256) {
        return userTokenBalances[tokenHolder];
    }

    function getBalance() public nonReentrant onlyOwner  {
        require(tokenBalance > 0, "Zero Balance");
        IERC20(tokenAddress).transfer(msg.sender, tokenBalance);
        tokenBalance = 0;
    }
}
