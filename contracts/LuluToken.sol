// SPDX-License-Identifier: unlicense
pragma solidity ^0.8.4;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract LuluToken is ERC20 {
    constructor() ERC20("Honululu", "LULU") {
        _mint(msg.sender, 100 ether);
    }
}
