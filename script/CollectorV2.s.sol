// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/CollectorV2.sol";
import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract DeployCollectorScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PPKK");
        vm.startBroadcast(deployerPrivateKey);

        CollectorV2 collector = new CollectorV2(
            [
                0x4bd98f245227536f86247a3f4f83cfD0dCA9D034,
                0x394c52f4c70F86cf86bC6b225C243844E0E89542,
                0x4614776Ba04e0d24a0C453361b0287aB1286D68a
            ]
        );

        vm.stopBroadcast();
    }
}

// ["0x4bd98f245227536f86247a3f4f83cfD0dCA9D034","0x394c52f4c70F86cf86bC6b225C243844E0E89542","0x4614776Ba04e0d24a0C453361b0287aB1286D68a"]
