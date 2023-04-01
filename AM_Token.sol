// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ManabuBananaToken is ERC20 {
    constructor() ERC20("Aizu Mujin Token", "AMT") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }
}
