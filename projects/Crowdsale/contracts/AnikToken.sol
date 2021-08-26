// SPDX-License-Identifier: MIT
pragma solidity ^0.6.1;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

// import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";

contract AnikToken is ERC20 {
    constructor(uint256 initialSupply) public ERC20("Anik Token", "AKT") {
        _mint(msg.sender, initialSupply);
        _setupDecimals(18);
    }
}
