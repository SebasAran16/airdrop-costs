// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {AirdropUtils} from "../../test/utils/AidropUtils.t.sol";

contract DeploymentHelper is AirdropUtils {
  string private constant BASE_URI = "ipfs://QmPKoP1YR5DtxfcSpFofVzZjPi7XA7UJpVMkbKSCKeMBQa/";
  string private constant BASE_1155_URI = "ipfs://QmPKoP1YR5DtxfcSpFofVzZjPi7XA7UJpVMkbKSCKeMBQa/{id}.json";
    uint256 private constant NFT_AMOUNT = 100_000;

    function getNFTDeploymentData() public pure returns (string memory, address, uint256) {
        return (BASE_URI, ANVIL_DEFAULT_ADDRESS, NFT_AMOUNT);
    }

    function getTokenDeploymentData() public pure returns (string memory, string memory, address, uint256) {
      return ("Test Token", "Test Token", ANVIL_DEFAULT_ADDRESS, 1_000_000 ether);
    }

    function get1155NFTDeploymentData() public pure returns (string memory, address, uint256) {
      return (BASE_1155_URI, ANVIL_DEFAULT_ADDRESS, NFT_AMOUNT);
    }

    function getNFTAirdropDeploymentData() public returns (string memory, address[] memory) {
        return (BASE_URI, generateAirdropAddresses(NFT_AMOUNT));
    }

    function get1155AirdropDeploymentData() public returns (string memory, address[] memory) {
      return (BASE_1155_URI, generateAirdropAddresses(NFT_AMOUNT));
    }
}
