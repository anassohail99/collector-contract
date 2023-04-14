// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/CollectorV2.sol";
import "./mockERC20.sol";

contract collectev2test is Test {
    CollectorV2 public collectorv2;
    Vm hevm = Vm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    MockERC20 public USDT;
    MockERC20 public BNB;
    MockERC20 public BUSD;
    MockERC20 public ETH;

    address alice = hevm.addr(1);
    address bob = hevm.addr(2);

    function setUp() public {
        USDT = new MockERC20();
        BNB = new MockERC20();
        BUSD = new MockERC20();
        ETH = new MockERC20();

        collectorv2 = new CollectorV2(
            [address(USDT), address(BUSD), address(ETH)]
        );
    }

    function testOwnerShip() public {
        hevm.expectRevert();
        hevm.prank(alice);
        collectorv2.addSupportedToken(address(BNB));
    }

    function testSupportedToken() public {
        assertEq(collectorv2.supportedTokens(address(USDT)), true);
        assertEq(collectorv2.supportedTokens(address(BUSD)), true);
        assertEq(collectorv2.supportedTokens(address(BNB)), false);
        assertEq(collectorv2.supportedTokens(address(ETH)), true);
    }

    function testAddSupportedToken() public {
        MockERC20 USDC = new MockERC20();
        collectorv2.addSupportedToken(address(USDC));
        assertEq(collectorv2.supportedTokens(address(USDC)), true);
    }

    function testRemoveSupportedToken() public {
        MockERC20 USDC = new MockERC20();
        collectorv2.removeSupportedToken(address(USDC));
        assertEq(collectorv2.supportedTokens(address(USDC)), false);
    }

    function testCollectV2() public {
        hevm.expectRevert(bytes("Amount must be greater than 0"));
        collectorv2.CollectV2(address(USDT), 0);

        // BNB transfer

        // Other token transfer
        MockERC20 USDC = new MockERC20();
        hevm.expectRevert(bytes("Token not supported"));
        collectorv2.CollectV2(address(USDC), 30);

        BUSD.transfer(address(alice), 10000);

        uint256 ownerBalanceBefore = BUSD.balanceOf(address(alice));

        hevm.prank(alice);
        BUSD.approve(address(collectorv2), 30);
        hevm.prank(alice);
        collectorv2.CollectV2(address(BUSD), 30);

        assertEq(collectorv2.getBalance(address(alice), address(BUSD)), 30);

        hevm.prank(alice);
        BUSD.approve(address(collectorv2), 30);
        hevm.prank(alice);
        collectorv2.CollectV2(address(BUSD), 30);

        assertEq(collectorv2.getBalance(address(alice), address(BUSD)), 60);
        assertEq(ownerBalanceBefore - 60, BUSD.balanceOf(address(alice)));
    }
}
// Remember to remove fixed array size
