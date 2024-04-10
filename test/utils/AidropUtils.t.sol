// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";

contract AirdropUtils is Test {
    address internal constant ANVIL_DEFAULT_ADDRESS = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;

    function generateAirdropAddresses(uint256 airdropNumber) internal returns (address[] memory) {
        address[] memory airdropAddresses = new address[](airdropNumber);

        for (uint256 i; i < airdropNumber; i++) {
            airdropAddresses[i] = makeAddr(string.concat("airdropAddress-", vm.toString(i)));
        }

        return airdropAddresses;
    }
}
