// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract NFTAirdrop is ERC1155 {
    uint256 private constant TOKEN_ID = 1;

    constructor(string memory baseUri, address[] memory receivers) ERC1155(baseUri) {
        for (uint256 i; i < receivers.length; i++) {
            _mint(receivers[i], TOKEN_ID, 1, "");
        }
    }
}
