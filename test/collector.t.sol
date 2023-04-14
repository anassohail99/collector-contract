// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/Collector.sol";
import "./mockERC20.sol";

contract CollectorTest is Test {
    Vm hevm = Vm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    Collector public collector;
    MockERC20 public token;

    address alice = hevm.addr(1);
    address bob = hevm.addr(2);

    function setUp() public {
        token = new MockERC20();
        collector = new Collector(address(token));
    }

    function testcannotCollect() public {
        hevm.expectRevert(bytes("Collector:: Not Approved"));
        collector.collect(10e18);
    }

    function testCollect() public {
        token.approve(address(collector), 10e18);
        collector.collect(10e18);
    }

    function testOwner() public {
        assertEq(collector.owner(), address(this));
    }

    function testAmountTransfer() public {
        collector.transferOwnership(alice);
        hevm.prank(address(this));
        token.approve(address(collector), 10e18);
        hevm.prank(address(this));
        collector.collect(10e18);

        assertEq(token.balanceOf(alice), 10e18);
    }

    function testUserBalance() public {
        token.approve(address(collector), 10e18);
        collector.collect(10e18);

        assertEq(collector.userBalance(address(this)), 10e18);
    }
}
