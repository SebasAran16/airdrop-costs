// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {GasliteDrop} from "gasliteDrop/GasliteDrop.sol";
import {IERC721} from "../../lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";
import {DeployGasliteDrop} from "../../script/DeployGasliteDrop.s.sol";
import {AirdropUtils} from "../utils/AidropUtils.t.sol";
import {DeployNFT} from "../../script/ERC721/DeployNFT.s.sol";

contract GasliteDropTest is Test, AirdropUtils {
    GasliteDrop private gasliteDropContract;
    IERC721 private nft;

    address[] private airdropAddresses;
    uint256[] private tokenIds;

    function setUp() public {
        DeployGasliteDrop gasliteDropDeployer = new DeployGasliteDrop();
        gasliteDropContract = gasliteDropDeployer.run();
        DeployNFT nftDeployer = new DeployNFT();
        nft = nftDeployer.run();

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
