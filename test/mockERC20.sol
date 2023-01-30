// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC20.sol";

contract MockERC20 is TokenContract {
    constructor() TokenContract(100000000e18, "Family Token", "FT") {
        // _mint(msg.sender, 10000000000000000000000000000);
    }
}
