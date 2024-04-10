// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {AirdropUtils} from "../utils/AidropUtils.t.sol";
import {NFTAirdrop} from "../../src/ERC721/NFTAirdrop.sol";
import {DeploymentHelper} from "../../script/utils/DeploymentHelper.sol";

contract NFT721AirdropTest is Test, AirdropUtils {
    struct DeploymentData {
        string baseURI;
        address[] receivers;
    }

    NFTAirdrop private nft;
    DeploymentHelper private deploymentHelper;
    DeploymentData private deploymentData;

    function setUp() public {
        deploymentHelper = new DeploymentHelper();
        (string memory baseURI, address[] memory airdropAddresses) = deploymentHelper.getNFTAirdropDeploymentData();

        deploymentData = DeploymentData({
            baseURI: baseURI,
            receivers: airdropAddresses
        });
    }

    function test_ERC721_deployAndAirdropNFTs() public {
        nft = new NFTAirdrop(deploymentData.baseURI, deploymentData.receivers);

        assertEq(nft.symbol(), "EMTI");
    }
}
