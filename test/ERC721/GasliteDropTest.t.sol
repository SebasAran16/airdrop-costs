// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {GasliteDrop} from "gasliteDrop/GasliteDrop.sol";
import {NFT721} from "../../src/ERC721/NFT721.sol";
import {DeployGasliteDrop} from "../../script/ERC721/DeployGasliteDrop.s.sol";
import {AirdropUtils} from "../utils/AidropUtils.t.sol";
import {DeploymentHelper} from "../../script/utils/DeploymentHelper.sol";

contract GasliteDropTest is Test, AirdropUtils {
    GasliteDrop private gasliteDropContract;
    NFT721 private nft;

    address[] private airdropAddresses;
    uint256[] private tokenIds;

    function setUp() public {
        DeploymentHelper deploymentHelper = new DeploymentHelper();

        gasliteDropContract = new GasliteDrop();
        (string memory baseURI, address owner, uint256 nftAmount) = deploymentHelper.getNFTDeploymentData();
        nft = new NFT721(baseURI, owner, nftAmount);

        uint256 totalAmount = nft.balanceOf(ANVIL_DEFAULT_ADDRESS);

        airdropAddresses = generateAirdropAddresses(totalAmount);
        tokenIds = new uint256[](totalAmount);

        for (uint256 i; i < totalAmount; i++) {
            tokenIds[i] = i;
        }
    }

    function test_ERC721_sendsNFTToRandomAddresses() public {
        vm.startPrank(ANVIL_DEFAULT_ADDRESS);
        nft.setApprovalForAll(address(gasliteDropContract), true);
        gasliteDropContract.airdropERC721(address(nft), airdropAddresses, tokenIds);
        vm.stopPrank();
    }
}
