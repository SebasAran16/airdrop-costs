// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {NFTAirdrop} from "../../src/ERC721/NFTAirdrop.sol";
import {DeploymentHelper} from "../utils/DeploymentHelper.sol";
import {IERC1155} from "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

contract DeployNFTAirdrop is Script {
  function run() public returns (IERC1155) {
    return deployNFT();
  }

  function deployNFT() public returns (IERC1155) {
    DeploymentHelper deploymentHelper = new DeploymentHelper();
    (string memory uri, address[] memory receivers) = deploymentHelper.get1155AirdropDeploymentData();
    NFTAirdrop nft = new NFTAirdrop(uri, receivers);

    return IERC1155(address(nft));
  }
}
