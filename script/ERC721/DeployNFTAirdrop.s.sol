// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {NFT721Airdrop} from "../../src/ERC721/NFT721Airdrop.sol";
import {IERC721} from "@openzeppelin/contracts/interfaces/IERC721.sol";
import {DeploymentHelper} from "../utils/DeploymentHelper.sol";

contract DeployNFTAirdrop is Script {
    function run() public returns (IERC721 nft) {
        nft = deployNFT();
    }

    function deployNFT() public returns (IERC721) {
        DeploymentHelper deploymentHelper = new DeploymentHelper();
        (string memory baseURI, address[] memory airdropAddresses) = deploymentHelper.getNFTAirdropDeploymentData();

        NFT721Airdrop nftAirdrop = new NFT721Airdrop(baseURI, airdropAddresses);
        return IERC721(nftAirdrop);
    }
}
