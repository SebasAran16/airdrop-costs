// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC20} from "../../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract TestToken is ERC20 {
    constructor(string memory tokenName, string memory tokenSymbol, address distributor, uint256 amount)
        ERC20(tokenName, tokenSymbol)
    {
        _mint(distributor, amount);
    }
}
