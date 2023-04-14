// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/Withdrawal.sol";
import "./mockERC20.sol";

contract WithrawalTest is Test {
    Vm hevm = Vm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    uint256 MAX_INT =
        115792089237316195423570985008687907853269984665640564039457584007913129639935;
    Withdrawal public withdrawal;
    MockERC20 public token;

    address alice = hevm.addr(1);
    address owner = hevm.addr(2);

    function setUp() public {
        token = new MockERC20();
        withdrawal = new Withdrawal(address(token));
    }

    function testWithdrawal() public {
        uint256 amount = 10e18;
        token.approve(address(withdrawal), amount);
        hevm.prank(address(alice));
        withdrawal.withdraw(amount);
        assertEq(token.balanceOf(address(alice)), amount);
    }

    function testUserBalance() public {
        uint256 amount = 10e18;
        token.approve(address(withdrawal), amount);
        hevm.prank(address(alice));
        withdrawal.withdraw(amount);

        withdrawal.getWithdrawnBalance(address(alice));
        uint256 balance = withdrawal.getWithdrawnBalance(address(alice));
        assertEq(balance, amount);
    }
}
