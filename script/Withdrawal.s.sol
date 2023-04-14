// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/Withdrawal.sol";
import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract DeployWithdrawScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PKEYTEST");
        vm.startBroadcast(deployerPrivateKey);

        Withdrawal withdrawal = new Withdrawal(
            0x6bf322e9db8b725E840dAc6fe403B923003584A0
        );

        vm.stopBroadcast();
    }
}
