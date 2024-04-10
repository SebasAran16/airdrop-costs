// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {NFT} from "../../src/ERC721/NFT.sol";
import {IERC721} from "@openzeppelin/contracts/interfaces/IERC721.sol";
import {DeploymentHelper} from "../utils/DeploymentHelper.sol";

contract DeployNFT is Script {
    function run() public returns (IERC721) {
        NFT nft = deployNFT();
        return IERC721(address(nft));
    }

    function deployNFT() public returns (NFT) {
        DeploymentHelper deploymentHelper = new DeploymentHelper();
        (string memory baseURI, address owner, uint256 nftAmount) = deploymentHelper.getNFTDeploymentData();

        return new NFT(baseURI, owner, nftAmount);
    }
}
