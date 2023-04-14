// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/Collector.sol";
import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract DeployCollectorScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PKEY");
        vm.startBroadcast(deployerPrivateKey);

        Collector collector = new Collector(
            0x439ecD2F575f84Ce1587e011116b899Bd0aF1552
        );

        vm.stopBroadcast();
    }
}
