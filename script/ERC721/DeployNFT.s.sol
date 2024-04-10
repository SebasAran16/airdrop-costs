// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {NFT721} from "../../src/ERC721/NFT721.sol";
import {IERC721} from "@openzeppelin/contracts/interfaces/IERC721.sol";
import {DeploymentHelper} from "../utils/DeploymentHelper.sol";

contract DeployNFT is Script {
    function run() public returns (IERC721) {
        NFT721 nft = deployNFT();
        return IERC721(address(nft));
    }

    function deployNFT() public returns (NFT721) {
        DeploymentHelper deploymentHelper = new DeploymentHelper();
        (string memory baseURI, address owner, uint256 nftAmount) = deploymentHelper.getNFTDeploymentData();

        return new NFT721(baseURI, owner, nftAmount);
    }
}
