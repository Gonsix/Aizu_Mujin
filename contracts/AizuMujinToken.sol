// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

//Changed class name to AizuMujinToken
contract AizuMujinToken is ERC20 {
    constructor() ERC20("Aizu Mujin Token", "AMT") {
        _mint(msg.sender, 100000000);
    }

    /*
    @title	'overricde dicimals function in ERC20
    @author	'Komeda
    @notice	'change the return value 18(default) to 0, because of being user frendly.
    @dev	'if you want to use this mint in a huge amount of people, you need the change to be removed
    @param	'none
    @return	'unit8
    */
    function decimals() public view virtual override returns (uint8) {
        return 0;
    }
    
}

