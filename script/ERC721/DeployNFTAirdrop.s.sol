// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {NFTAirdrop} from "../../src/ERC721/NFTAirdrop.sol";
import {IERC721} from "@openzeppelin/contracts/interfaces/IERC721.sol";
import {DeploymentHelper} from "../utils/DeploymentHelper.sol";

contract DeployNFTAirdrop is Script {
    function run() public returns (IERC721 nft) {
        nft = deployNFT();
    }

    function deployNFT() public returns (IERC721) {
        DeploymentHelper deploymentHelper = new DeploymentHelper();
        (string memory baseURI, address[] memory airdropAddresses) = deploymentHelper.getNFTAirdropDeploymentData();

        NFTAirdrop nftAirdrop = new NFTAirdrop(baseURI, airdropAddresses);
        return IERC721(nftAirdrop);
    }
}
