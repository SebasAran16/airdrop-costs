// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {NFT1155} from "../../src/ERC1155/NFT1155.sol";
import {DeploymentHelper} from "../utils/DeploymentHelper.sol";
import {IERC1155} from "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

contract DeployNFT is Script {
    function run() public returns (IERC1155) {
        return deployNFT();
    }

    function deployNFT() public returns (IERC1155) {
        DeploymentHelper deploymentHelper = new DeploymentHelper();
        (string memory uri, address owner, uint256 totalAmount) = deploymentHelper.get1155NFTDeploymentData();
        NFT1155 nft = new NFT1155(uri, owner, totalAmount);

        return IERC1155(address(nft));
    }
}
