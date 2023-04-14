// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "openzeppelin-contracts/contracts/security/ReentrancyGuard.sol";

contract Withdrawal is Ownable, ReentrancyGuard {
    address public tokenAddress;
    uint256 public totalWithdrawned;
    mapping(address => uint256) internal userWithdrawn;

    event Withdrawn(address indexed user, uint256 amount);

    constructor(address _tokenAddress) {
        tokenAddress = _tokenAddress;
    }

    function withdraw(uint256 amount) public {
        require(amount > 0, "Withdraw:: Amount cannot be zero");
        require(
            IERC20(tokenAddress).allowance(owner(), address(this)) >= amount,
            "Approval:: Not Enough Approval"
        );
        IERC20(tokenAddress).transferFrom(owner(), msg.sender, amount);
        totalWithdrawned += amount;
        userWithdrawn[msg.sender] = amount;
        emit Withdrawn(msg.sender, amount);
    }

    function getWithdrawnBalance(
        address userAddress
    ) public view returns (uint256) {
        return userWithdrawn[userAddress];
    }
}
