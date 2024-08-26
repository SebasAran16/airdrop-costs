// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {AirdropUtils} from "../utils/AidropUtils.t.sol";
import {NFT1155Airdrop} from "../../src/ERC1155/NFT1155Airdrop.sol";
import {DeployNFTAirdrop} from "../../script/ERC1155/DeployNFTAirdrop.s.sol";
import {DeploymentHelper} from "../../script/utils/DeploymentHelper.sol";

contract NFT1155AirdropTest is Test, AirdropUtils {
    struct DeploymentData {
        string baseURI;
        address[] receivers;
    }

    NFT1155Airdrop private nft;
    DeploymentHelper private deploymentHelper;
    DeploymentData private deploymentData;
    uint256 private constant TOKEN_ID = 1;

    function setUp() public {
        deploymentHelper = new DeploymentHelper();
        (string memory baseURI, address[] memory airdropAddresses) = deploymentHelper.get1155AirdropDeploymentData();

        deploymentData = DeploymentData({baseURI: baseURI, receivers: airdropAddresses});
    }

    function test_ERC1155_deployAndAirdropNFTsVerifyReceived() public {
        nft = new NFT1155Airdrop(deploymentData.baseURI, deploymentData.receivers);

        for (uint256 i; i < deploymentData.receivers.length; i++) {
            vm.assertEq(NFT_AIRDROP_AMOUNT, nft.balanceOf(deploymentData.receivers[i], TOKEN_ID));
        }
    }
}
